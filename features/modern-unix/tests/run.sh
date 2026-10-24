#!/usr/bin/env bash
set -euo pipefail

feature=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$feature/../.." && pwd)
fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
for tool in bash zsh jq rsync python3 git lazygit hunk fzf rg eza zoxide tldr btop fastfetch dua; do
    command -v "$tool" >/dev/null || fail "missing test dependency: $tool"
done
command -v bat >/dev/null || command -v batcat >/dev/null || fail 'missing bat/batcat'
command -v fd >/dev/null || command -v fdfind >/dev/null || fail 'missing fd/fdfind'

for script in "$feature/install/"*.sh "$feature/post-configure.sh"; do sh -n "$script"; done
for shell in bash zsh; do
    for script in "$feature/config/.my-shell-conf/confs/generic/"*.sh \
        "$feature/config/.my-shell-conf/confs/$shell/"*.sh; do "$shell" -n "$script"; done
done
cmp "$repo/core/install.sh" "$feature/install.sh"
cmp "$repo/core/configure.sh" "$feature/configure.sh"
jq -e '.id == "modern-unix" and .dependsOn["./core"] == {}' "$feature/devcontainer-feature.json" >/dev/null
jq -e '.logo.type == "none" and (.modules | index("cpu") != null)' \
    "$feature/config/.config/fastfetch/config.jsonc" >/dev/null

test_root=$(mktemp -d /tmp/modern-unix-test.XXXXXX)
cleanup() {
    case "$test_root" in /tmp/modern-unix-test.??????) ;; *) fail "unsafe cleanup: $test_root";; esac
    find "$test_root" -depth -delete
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM
export HOME="$test_root/home"
export XDG_CONFIG_HOME="$HOME/.config" XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache" XDG_STATE_HOME="$HOME/.local/state"
export PATH="$HOME/.local/bin:$PATH" TERM=xterm-256color
unset FZF_DEFAULT_OPTS FZF_DEFAULT_COMMAND BAT_THEME BAT_CONFIG_PATH
mkdir -p "$HOME/.my-shell-conf/confs/generic" "$HOME/.config/nvim" "$test_root/files"
cp "$repo/core/config/.my-shell-conf/kickstart.sh" "$HOME/.my-shell-conf/"
cp "$repo/core/config/.my-shell-conf/confs/generic/bin.sh" \
    "$repo/core/config/.my-shell-conf/confs/generic/colors.sh" "$HOME/.my-shell-conf/confs/generic/"
printf ': # preserve tmux\n' > "$HOME/.my-shell-conf/confs/generic/tmux.sh"
printf 'preserve\n' > "$HOME/.config/nvim/marker"
for attempt in 1 2; do
    "$feature/configure.sh" "$HOME" > "$test_root/configure.log"
    cmp "$feature/config/.config/btop/btop.conf" "$HOME/.config/btop/btop.conf"
    cmp "$feature/config/.config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    cmp "$feature/config/.config/tealdeer/config.toml" "$HOME/.config/tealdeer/config.toml"
    [ "$(cat "$HOME/.config/nvim/marker")" = preserve ] || fail 'Neovim configuration changed'
    grep -q 'preserve tmux' "$HOME/.my-shell-conf/confs/generic/tmux.sh" || fail 'tmux configuration changed'
done
mkdir -p "$test_root/home with spaces"
"$feature/configure.sh" "$test_root/home with spaces" > "$test_root/configure-spaces.log"
cmp "$feature/config/.config/btop/btop.conf" "$test_root/home with spaces/.config/btop/btop.conf"
if [ "$(uname -s)" = Linux ]; then
    for name in bat fd; do
        [ -x "$test_root/home with spaces/.local/bin/$name" ] || fail "alternate home missing $name"
    done
fi

export FEATURE="$feature" TEST_FILES="$test_root/files"
export ALIAS_FILES="$test_root/alias-files"
mkdir "$ALIAS_FILES"
printf 'alias fixture\n' > "$ALIAS_FILES/alias-visible.txt"
printf 'hidden fixture\n' > "$ALIAS_FILES/.alias-hidden.txt"
mkdir "$test_root/startup-bin"
cat > "$test_root/startup-bin/fastfetch" <<'MOCK'
#!/bin/sh
printf 'unexpected Fastfetch startup\n' >&2
exit 19
MOCK
chmod +x "$test_root/startup-bin/fastfetch"
cat > "$test_root/shell-integration.sh" <<'SHELL'
        set -e
        . "$HOME/.my-shell-conf/confs/generic/colors.sh"
        original_ls=$(alias ls)
        alias cd="builtin cd"
        export PAGER=less EDITOR=vi
        . "$HOME/.my-shell-conf/kickstart.sh"
        . "$HOME/.my-shell-conf/kickstart.sh"
        [ "$(alias ls)" = "$original_ls" ]
        alias cd | grep "builtin cd"
        [ "$PAGER" = less ] && [ "$EDITOR" = vi ] && [ "$BAT_THEME" = ansi ]
        for name in mcat mls mdiff mdu mdf mtree mfind mgrep mjson msd mtop mping mdig ll la; do
            alias "$name"
        done
        alias mls | grep eza
        alias mdiff | grep "hunk diff"
        alias mdu | grep "dua aggregate"
        alias mtree | grep "eza --tree"
        alias mtop | grep btop
        alias ll | grep "eza -lh"
        alias la | grep "eza -lha"
        for name in mhistory mps; do
            if alias "$name" >/dev/null 2>&1; then
                printf "Unexpected obsolete alias: %s\n" "$name" >&2
                exit 1
            fi
        done
        mls "$ALIAS_FILES" | grep alias-visible.txt
        ll "$ALIAS_FILES" | grep alias-visible.txt
        la "$ALIAS_FILES" | grep .alias-hidden.txt
        mtree "$ALIAS_FILES" | grep alias-visible.txt
        mdu --format bytes "$ALIAS_FILES" | grep alias-visible.txt
        mdiff --help | grep "review diffs"
        mtop --version | grep btop
        command -v ff z zi bat fd
        zoxide add "$TEST_FILES"
        z "$TEST_FILES"
        [ "$PWD" = "$TEST_FILES" ]
        if [ -n "${BASH_VERSION:-}" ]; then
            if [ "${BASH_VERSINFO[0]}" -ge 4 ]; then
                bind -X | grep -F "\C-r" | grep __fzf_history__
            else
                bind -s | grep -F "\C-r" | grep __fzf_history__
            fi
            complete -p cd | grep _fzf
        else
            bindkey "^R" | grep fzf-history-widget
            bindkey -M viins "^R" | grep fzf-history-widget
            typeset -f _fzf_complete >/dev/null
        fi
        printf "PASS: shell integration\n"
SHELL
for shell in bash zsh; do
    PATH="$test_root/startup-bin:$PATH" python3 "$feature/tests/terminal.py" --shell "$shell" "$test_root/shell-integration.sh" \
        > "$test_root/$shell.log" 2>&1 || { cat "$test_root/$shell.log" >&2; fail "$shell integration"; }
    grep -q 'PASS: shell integration' "$test_root/$shell.log" || fail "$shell assertions"
    if grep -Ei 'not found|unknown option|parse error|modern-unix:.*failed|unexpected Fastfetch' "$test_root/$shell.log"; then
        fail "$shell startup diagnostics"
    fi
done

cd "$test_root/files"
git init -q
printf 'ignored.txt\n' > .gitignore
printf 'needle\n' > visible.txt
printf 'needle\n' > ignored.txt
printf 'needle\n' > .hidden.txt
[ "$(fd --type f)" = visible.txt ] || fail 'fd default filtering'
[ "$(rg -l needle)" = visible.txt ] || fail 'rg default filtering'
BAT_THEME=ansi bat --color=always --paging=never visible.txt > "$test_root/bat.log"
grep -q needle "$test_root/bat.log" || fail 'bat output'
. "$feature/config/.my-shell-conf/confs/generic/fzf.sh"
[ "$(printf 'visible.txt\n' | ff --filter visible)" = visible.txt ] || fail 'ff selection'
set +e
printf 'visible.txt\n' | ff --filter missing > /dev/null
result=$?
set -e
[ "$result" -eq 1 ] || fail 'ff empty-result status'

for tool in lazygit hunk fd fzf rg bat eza zoxide tldr btop fastfetch dua; do
    "$tool" --version > "$test_root/$tool-version.log" 2>&1 ||
        { cat "$test_root/$tool-version.log" >&2; fail "$tool version"; }
done
eza --tree --level=2 --color=always . > "$test_root/eza.log"
grep -q visible.txt "$test_root/eza.log" || fail 'eza tree'
dua aggregate . > "$test_root/dua.log"
fastfetch --format json > "$test_root/fastfetch.json"
jq -e 'length == 8 and ([.[].type | ascii_downcase] | index("cpu") != null)' \
    "$test_root/fastfetch.json" >/dev/null
jq -e 'all(.[] | select((.type | ascii_downcase) == "cpu" or (.type | ascii_downcase) == "memory"); has("result"))' \
    "$test_root/fastfetch.json" >/dev/null

# Exercise page rendering without making the regression suite depend on a download.
printf '# modern-unix-test\n\n> Local test page.\n\n- Print a message:\n\n`echo modern-unix-test`\n' \
    > "$test_root/modern-unix-test.md"
tldr --render "$test_root/modern-unix-test.md" > "$test_root/tldr.log"
grep -q 'echo modern-unix-test' "$test_root/tldr.log" || fail 'tldr page rendering'

mkdir -p "$test_root/mock-bin" "$test_root/mock-prefix/var/homebrew/linked" "$test_root/mock-feature/install"
export MOCK_ROOT="$test_root" MOCK_FAILURE=0 MOCK_ARCH=aarch64
cat > "$test_root/mock-bin/brew" <<'MOCK'
#!/bin/sh
if [ "$1" = --prefix ]; then printf '%s/mock-prefix\n' "$MOCK_ROOT"; exit; fi
printf 'brew %s\n' "$*" >> "$MOCK_ROOT/commands"
[ "$MOCK_FAILURE" != brew ] || { printf 'simulated brew failure\n' >&2; exit 19; }
MOCK
cat > "$test_root/mock-bin/uname" <<'MOCK'
#!/bin/sh
case "$1" in -m) printf '%s\n' "$MOCK_ARCH";; *) printf 'Linux\n';; esac
MOCK
cat > "$test_root/mock-bin/sudo" <<'MOCK'
#!/bin/sh
printf 'sudo %s\n' "$*" >> "$MOCK_ROOT/commands"
[ "$MOCK_FAILURE" != apt ] || { printf 'simulated apt failure\n' >&2; exit 19; }
MOCK
cat > "$test_root/mock-bin/apt-cache" <<'MOCK'
#!/bin/sh
printf '  Candidate: 0.67.0\n'
MOCK
cat > "$test_root/mock-bin/dpkg" <<'MOCK'
#!/bin/sh
[ "$MOCK_FAILURE" != version ]
MOCK
cat > "$test_root/mock-bin/curl" <<'MOCK'
#!/bin/sh
printf 'curl %s\n' "$*" >> "$MOCK_ROOT/commands"
[ "$MOCK_FAILURE" != download ] || { printf 'simulated download failure\n' >&2; exit 22; }
if [ "$MOCK_FAILURE" = hunk-download ]; then
    case "$*" in *hunkdiff*) printf 'simulated Hunk download failure\n' >&2; exit 22;; esac
fi
MOCK
cat > "$test_root/mock-bin/sha256sum" <<'MOCK'
#!/bin/sh
input=$(cat)
printf '%s\n' "$input" >> "$MOCK_ROOT/commands"
if [ "$MOCK_FAILURE" = checksum ]; then exit 1; fi
if [ "$MOCK_FAILURE" = hunk-checksum ]; then
    case "$input" in *hunk.tar.gz*) exit 1;; esac
fi
MOCK
cat > "$test_root/mock-bin/tar" <<'MOCK'
#!/bin/sh
printf 'tar %s\n' "$*" >> "$MOCK_ROOT/commands"
[ "$MOCK_FAILURE" != archive ] || { printf 'simulated extraction failure\n' >&2; exit 2; }
if [ "$MOCK_FAILURE" = hunk-archive ]; then
    case "$*" in *hunkdiff*) printf 'simulated Hunk extraction failure\n' >&2; exit 2;; esac
fi
printf '#!/bin/sh\nprintf "dua 2.46.0\\n"\n'
MOCK
cat > "$test_root/mock-bin/cmp" <<'MOCK'
#!/bin/sh
if [ "$MOCK_FAILURE" = hunk-collision ]; then
    case "$*" in */usr/local/bin/hunk) exit 1;; esac
fi
exit 0
MOCK
cat > "$test_root/mock-feature/configure.sh" <<'MOCK'
#!/bin/sh
touch "$MOCK_ROOT/configured"
MOCK
chmod +x "$test_root/mock-bin/"* "$test_root/mock-feature/configure.sh"
cp "$feature/install.sh" "$test_root/mock-feature/"
cp "$feature/install/"*.sh "$test_root/mock-feature/install/"
cp "$feature/install/ubuntu.sh" "$test_root/mock-feature/install/install.sh"
mock_path="$test_root/mock-bin:$PATH"
for failure in apt version download checksum archive hunk-download hunk-checksum hunk-archive; do
    export MOCK_FAILURE="$failure"
    : > "$test_root/commands"
    if PATH="$mock_path" "$test_root/mock-feature/install.sh" > "$test_root/failure.log" 2>&1; then
        fail "$failure failure was ignored"
    fi
    [ ! -e "$test_root/configured" ] || fail "configuration ran after $failure"
    [ -s "$test_root/failure.log" ] || fail "missing $failure diagnostic"
    case "$failure" in
        hunk-*) grep -qi hunk "$test_root/failure.log" || fail "missing Hunk failure diagnostic";;
    esac
done
export MOCK_FAILURE=0
for architecture in aarch64 x86_64; do
    export MOCK_ARCH="$architecture"
    : > "$test_root/commands"
    PATH="$mock_path" "$test_root/mock-feature/install.sh" > "$test_root/install.log"
    [ -f "$test_root/configured" ] || fail 'successful installer did not configure'
    case "$architecture" in
        aarch64)
            grep -q 'hunkdiff-linux-arm64.tar.gz' "$test_root/commands" || fail 'Hunk ARM64 archive'
            grep -q eaaba9f5c0c184db4a8493ac386b112ee8cbb553884c4a0e5e04138def5e2d29 "$test_root/commands" ||
                fail 'Hunk ARM64 digest'
            ;;
        x86_64)
            grep -q 'hunkdiff-linux-x64.tar.gz' "$test_root/commands" || fail 'Hunk x86_64 archive'
            grep -q 7656402a8ebbd5117ad24e12bda1af045fc9c85c3b40e72dbfde4dea79b60c69 "$test_root/commands" ||
                fail 'Hunk x86_64 digest'
            ;;
    esac
    rm "$test_root/configured"
done
if [ -f /usr/local/bin/hunk ]; then
    export MOCK_FAILURE=hunk-collision
    if PATH="$mock_path" "$test_root/mock-feature/install.sh" > "$test_root/failure.log" 2>&1; then
        fail 'existing Hunk collision ignored'
    fi
    grep -q 'refusing to replace an existing /usr/local/bin/hunk' "$test_root/failure.log" ||
        fail 'Hunk collision diagnostic'
    [ ! -e "$test_root/configured" ] || fail 'configuration ran after Hunk collision'
fi
export MOCK_FAILURE=brew
if PATH="$mock_path" "$feature/install/macos.sh" > "$test_root/failure.log" 2>&1; then fail 'brew failure ignored'; fi
export MOCK_FAILURE=0 MOCK_ARCH=unsupported
if PATH="$mock_path" "$feature/install/ubuntu.sh" > "$test_root/failure.log" 2>&1; then fail 'unsupported architecture accepted'; fi
grep -q 'ARM64 and x86_64 only' "$test_root/failure.log" || fail 'architecture diagnostic'
mkdir "$test_root/mock-prefix/var/homebrew/linked/tldr"
if PATH="$mock_path" "$feature/install/macos.sh" > "$test_root/failure.log" 2>&1; then fail 'conflicting tldr client accepted'; fi
grep -q 'brew unlink tldr' "$test_root/failure.log" || fail 'tldr conflict guidance'
rmdir "$test_root/mock-prefix/var/homebrew/linked/tldr"
: > "$test_root/commands"
PATH="$mock_path" "$feature/install/macos.sh" > "$test_root/install.log"
for package in glow bat duf fd ripgrep fzf jq sd tealdeer \
    gping httpie doggo lazygit hunk eza zoxide btop fastfetch dua-cli; do
    grep -qx "brew install $package" "$test_root/commands" || fail "macOS package missing: $package"
done
for package in delta git-delta lsd dust broot mcfly cheat glances procs; do
    if grep -qx "brew install $package" "$test_root/commands"; then
        fail "superseded macOS package requested: $package"
    fi
done

for packaged in batcat fdfind; do
    printf '#!/bin/sh\nexit 0\n' > "$test_root/mock-bin/$packaged"
    chmod +x "$test_root/mock-bin/$packaged"
done
mkdir -p "$test_root/collision/.local/bin"
printf 'preserve\n' > "$test_root/collision/.local/bin/bat"
if PATH="$mock_path" "$feature/post-configure.sh" "$test_root/collision" > "$test_root/failure.log" 2>&1; then
    fail 'command collision accepted'
fi
[ "$(cat "$test_root/collision/.local/bin/bat")" = preserve ] || fail 'custom command overwritten'
mkdir -p "$test_root/linked"
ln -s "$test_root/collision/.local" "$test_root/linked/.local"
if PATH="$mock_path" "$feature/post-configure.sh" "$test_root/linked" > "$test_root/failure.log" 2>&1; then
    fail 'symlinked command directory accepted'
fi

for tool in fzf zoxide; do
    printf '#!/bin/sh\nprintf "simulated initialization failure\\n" >&2\nexit 17\n' > "$test_root/mock-bin/$tool"
    chmod +x "$test_root/mock-bin/$tool"
    for shell in bash zsh; do
        if PATH="$mock_path" "$shell" -c '. "$1"' test "$feature/config/.my-shell-conf/confs/$shell/$tool.sh" \
            > "$test_root/failure.log" 2>&1; then fail "$shell $tool initialization failure ignored"; fi
        grep -q 'modern-unix: could not initialize' "$test_root/failure.log" || fail "$shell $tool diagnostic"
    done
done
python3 "$feature/tests/terminal.py" "$test_root/files"
printf 'PASS: modern-unix structure, installers, configuration, Bash/Zsh, commands, and terminal smoke checks (%s)\n' "$(uname -s)"
