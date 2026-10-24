#!/usr/bin/env bash
set -euo pipefail

feature=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$feature/../.." && pwd)
for tool in bash zsh jq rsync nvim git curl tar unzip cc rg; do
    command -v "$tool" >/dev/null || { printf 'Missing test dependency: %s\n' "$tool" >&2; exit 1; }
done
command -v fd >/dev/null || command -v fdfind >/dev/null ||
    { printf 'Missing test dependency: fd/fdfind\n' >&2; exit 1; }

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }

for script in "$feature/pre-configure.sh" "$feature/install/"*.sh; do sh -n "$script"; done
for shell in bash zsh; do "$shell" -n "$feature/config/.my-shell-conf/confs/generic/editor.sh"; done
cmp "$repo/core/install.sh" "$feature/install.sh"
cmp "$repo/core/configure.sh" "$feature/configure.sh"
jq -e '.id == "neovim" and .dependsOn["./core"] == {}' "$feature/devcontainer-feature.json" >/dev/null
jq -e '.features["./features/neovim"] == {} and
    (.overrideFeatureInstallOrder | index("./features/neovim") != null) and
    (.features | has("./features/lazyvim") | not) and
    (.overrideFeatureInstallOrder | index("./features/lazyvim") == null)' \
    "$repo/.devcontainer/devcontainer.json" >/dev/null

test_root=$(mktemp -d /tmp/neovim-test.XXXXXX)
cleanup() {
    case "$test_root" in /tmp/neovim-test.??????) ;; *) fail "unsafe test cleanup: $test_root" ;; esac
    find "$test_root" -depth -delete
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM
export HOME="$test_root/home"
export XDG_CONFIG_HOME="$HOME/.config" XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state" XDG_CACHE_HOME="$HOME/.cache"
unset SSH_CONNECTION SSH_TTY TMUX HERDR_PANE_ID
mkdir -p "$HOME/.my-shell-conf/confs/generic" "$HOME/.vim"
cp "$repo/core/config/.my-shell-conf/kickstart.sh" "$HOME/.my-shell-conf/"
for module in tmux herdr; do
    cp "$repo/features/$module/config/.my-shell-conf/confs/generic/$module.sh" \
        "$HOME/.my-shell-conf/confs/generic/"
done
printf 'preserve\n' > "$HOME/.vim/marker"

for attempt in 1 2; do
    for relative in .config/nvim .local/share/nvim .local/state/nvim .cache/nvim; do
        mkdir -p "$HOME/$relative"
        printf 'reset\n' > "$HOME/$relative/marker"
    done
    "$feature/configure.sh" "$HOME" > "$test_root/configure.log"
    for relative in .config/nvim .local/share/nvim .local/state/nvim .cache/nvim; do
        [ ! -e "$HOME/$relative/marker" ] || fail "reset missed $relative"
    done
    cmp "$feature/config/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
    [ "$(cat "$HOME/.vim/marker")" = preserve ] || fail 'Vim was changed'
    for module in tmux herdr; do
        cmp "$repo/features/$module/config/.my-shell-conf/confs/generic/$module.sh" \
            "$HOME/.my-shell-conf/confs/generic/$module.sh"
    done
done
for shell in bash zsh; do
    "$shell" -ic 'source "$HOME/.my-shell-conf/kickstart.sh"; test "$EDITOR" = nvim; command -v tdl; command -v hdl; eval "n --version"' \
        > "$test_root/shell.log" 2>&1 || { cat "$test_root/shell.log" >&2; fail "$shell integration"; }
    grep -q '^NVIM v' "$test_root/shell.log" || fail "$shell n shortcut"
done
mkdir -p "$test_root/home with spaces/.config/nvim"
printf 'reset\n' > "$test_root/home with spaces/.config/nvim/marker"
"$feature/configure.sh" "$test_root/home with spaces" > "$test_root/configure-spaces.log"
[ ! -e "$test_root/home with spaces/.config/nvim/marker" ] || fail 'reset with spaces'
cmp "$feature/config/.config/nvim/init.lua" "$test_root/home with spaces/.config/nvim/init.lua"

for destination in / "$repo" "$test_root/missing" ""; do
    if "$feature/pre-configure.sh" "$destination" > "$test_root/refused.log" 2>&1; then
        fail "unsafe destination accepted: $destination"
    fi
    grep -q 'reset refused' "$test_root/refused.log" || fail 'missing reset diagnostic'
done
mkdir -p "$test_root/outside" "$test_root/unsafe/.config/nvim" "$test_root/unsafe/.local"
printf 'preserve\n' > "$test_root/outside/marker"
printf 'preserve\n' > "$test_root/unsafe/.config/nvim/marker"
ln -s "$test_root/outside" "$test_root/unsafe/.local/share"
if "$feature/configure.sh" "$test_root/unsafe" > "$test_root/refused.log" 2>&1; then
    fail 'symlink parent accepted'
fi
[ -f "$test_root/unsafe/.config/nvim/marker" ] || fail 'reset started before validation completed'
[ -f "$test_root/outside/marker" ] || fail 'symlink target changed'
ln -s "$test_root/outside" "$test_root/destination-link"
if "$feature/pre-configure.sh" "$test_root/destination-link//" > "$test_root/refused.log" 2>&1; then
    fail 'symlink destination accepted'
fi
mkdir -p "$test_root/linked/.config"
ln -s "$test_root/outside" "$test_root/linked/.config/nvim"
if "$feature/configure.sh" "$test_root/linked" > "$test_root/refused.log" 2>&1; then
    fail 'symlink target accepted'
fi

mkdir -p "$test_root/mock-bin" "$test_root/failure-feature/install"
cat > "$test_root/mock-bin/brew" <<'MOCK'
#!/bin/sh
printf 'simulated package-manager failure\n' >&2
exit 19
MOCK
cp "$test_root/mock-bin/brew" "$test_root/mock-bin/sudo"
cat > "$test_root/failure-feature/configure.sh" <<'MOCK'
#!/bin/sh
touch "$HOME/unexpected-configuration"
MOCK
chmod +x "$test_root/mock-bin/"* "$test_root/failure-feature/configure.sh"
cp "$feature/install.sh" "$test_root/failure-feature/install.sh"
cp "$feature/install/"*.sh "$test_root/failure-feature/install/"
if PATH="$test_root/mock-bin:$PATH" "$test_root/failure-feature/install.sh" > "$test_root/install.log" 2>&1; then
    fail 'package-manager failure was ignored'
fi
[ ! -e "$HOME/unexpected-configuration" ] || fail 'configuration ran after installation failed'
cat > "$test_root/mock-bin/sudo" <<'MOCK'
#!/bin/sh
exit 0
MOCK
cat > "$test_root/mock-bin/apt-cache" <<'MOCK'
#!/bin/sh
printf '  Candidate: 0.9.5-1\n'
MOCK
cat > "$test_root/mock-bin/dpkg" <<'MOCK'
#!/bin/sh
exit 1
MOCK
chmod +x "$test_root/mock-bin/"*
if PATH="$test_root/mock-bin:$PATH" "$feature/install/ubuntu.sh" > "$test_root/install.log" 2>&1; then
    fail 'unsupported Ubuntu Neovim candidate accepted'
fi
grep -q 'Neovim >= 0.11.2 is required' "$test_root/install.log" || fail 'missing compatibility diagnostic'
printf 'PASS: feature structure, reset safety, preservation, installer failures, Bash and Zsh\n'

export NVIM_TEST_RUNTIME="$feature/tests/runtime.lua"
nvim --headless -i NONE '+lua dofile(vim.env.NVIM_TEST_RUNTIME)' > "$test_root/runtime.log" 2>&1 ||
    { tail -n 100 "$test_root/runtime.log" >&2; fail 'runtime validation'; }
if grep -E 'Error (in|detected)|Failed to run|Installation was aborted' "$test_root/runtime.log"; then
    fail 'first-launch diagnostics'
fi
grep 'PASS:' "$test_root/runtime.log"
SSH_CONNECTION='127.0.0.1 1 127.0.0.1 2' nvim --headless -i NONE \
    '+lua if vim.o.clipboard ~= "" or vim.g.clipboard ~= nil then vim.cmd("cquit") end' +qa
printf 'PASS: SSH clipboard defaults (%s)\n' "$(uname -s)"
