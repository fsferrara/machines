#!/usr/bin/env bash
set -euo pipefail

feature=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$feature/../.." && pwd)
for tool in jq rsync awk; do
    command -v "$tool" >/dev/null || { printf 'Missing test dependency: %s\n' "$tool" >&2; exit 1; }
done
fail() {
    printf 'FAIL: %s\n' "$*" >&2
    exit 1
}
for script in install.sh configure.sh pre-configure.sh install/macos.sh install/ubuntu.sh; do
    [ -x "$feature/$script" ] || fail "not executable: $script"
    sh -n "$feature/$script"
done
cmp "$repo/core/install.sh" "$feature/install.sh"
cmp "$repo/core/configure.sh" "$feature/configure.sh"
jq -e '.id == "cliamp" and .name == "my feature cliamp"
    and .dependsOn == {"./core": {}}' "$feature/devcontainer-feature.json" >/dev/null

test_root=$(mktemp -d /tmp/cliamp-test.XXXXXX)
cleanup() {
    case "$test_root" in /tmp/cliamp-test.??????) ;; *) return 1 ;; esac
    find "$test_root" -depth -delete
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM
export HOME="$test_root/home"
export XDG_CONFIG_HOME="$test_root/xdg" CLIAMP_CONFIG_DIR="$test_root/override"
mkdir -p "$HOME" "$XDG_CONFIG_HOME/cliamp" "$CLIAMP_CONFIG_DIR"
printf 'untouched\n' > "$CLIAMP_CONFIG_DIR/config.toml"
printf 'untouched\n' > "$XDG_CONFIG_HOME/cliamp/config.toml"
destination="$test_root/target home"
config="$destination/.config/cliamp/config.toml"

configure() {
    "$feature/configure.sh" "$destination" > "$test_root/configure.log" 2>&1 ||
        { cat "$test_root/configure.log" >&2; fail configuration; }
}
refuse_configuration() {
    if "$feature/configure.sh" "$destination" > "$test_root/configure.log" 2>&1; then
        fail "unsafe configuration accepted"
    fi
    grep 'cliamp:' "$test_root/configure.log" >/dev/null || fail 'missing configuration diagnostic'
    [ -z "$(find "$destination" -name '.machines-theme.*' -print)" ] || fail 'temporary file leaked'
}
mode() {
    if [ "$(uname -s)" = Darwin ]; then stat -f %Lp "$1"; else stat -c %a "$1"; fi
}
inode() {
    if [ "$(uname -s)" = Darwin ]; then stat -f %i "$1"; else stat -c %i "$1"; fi
}

configure
cmp "$feature/config/.config/cliamp/config.toml.example" "$config"
[ "$(mode "$config")" = 600 ] || fail 'new config is not private'
before=$(inode "$config")
configure
[ "$before" = "$(inode "$config")" ] || fail 'unchanged config replaced'
[ ! -e "$HOME/.config" ] || fail 'wrong home configured'
grep -Fx untouched "$CLIAMP_CONFIG_DIR/config.toml" >/dev/null
grep -Fx untouched "$XDG_CONFIG_HOME/cliamp/config.toml" >/dev/null

cat > "$config" <<'CONFIG'
# Personal settings
volume = -12
  theme  = 'gruvbox' # Keep this comment
shuffle = true
[navidrome]
url = "https://music.example"
password = "personal secret"
theme = "provider setting, not the root theme"
CONFIG
cat > "$test_root/expected" <<'CONFIG'
# Personal settings
volume = -12
  # Keep this comment
  theme  = "tokyo-night"
shuffle = true
[navidrome]
url = "https://music.example"
password = "personal secret"
theme = "provider setting, not the root theme"
CONFIG
chmod 640 "$config"
printf 'playlist\n' > "$destination/.config/cliamp/playlists.toml"
printf 'state\n' > "$destination/.config/cliamp/state.json"
ln -s state.json "$destination/.config/cliamp/personal-link"
mkdir -p "$destination/.my-shell-conf/confs/generic"
printf 'other feature\n' > "$destination/.my-shell-conf/confs/generic/tmux.sh"
configure
cmp "$test_root/expected" "$config"
[ "$(mode "$config")" = 640 ] || fail 'config permissions changed'
grep -Fx playlist "$destination/.config/cliamp/playlists.toml" >/dev/null
grep -Fx state "$destination/.config/cliamp/state.json" >/dev/null
[ "$(readlink "$destination/.config/cliamp/personal-link")" = state.json ]
grep -Fx 'other feature' "$destination/.my-shell-conf/confs/generic/tmux.sh" >/dev/null
before=$(inode "$config")
configure
[ "$before" = "$(inode "$config")" ] || fail 'repeat configuration not a no-op'

for content in '# no theme' 'volume = -5' '[radio]' ''; do
    printf '%s\n' "$content" > "$config"
    configure
    [ "$(grep -c '^theme = "tokyo-night"$' "$config")" = 1 ]
    if [ "$content" = '[radio]' ]; then
        [ "$(head -n 1 "$config")" = 'theme = "tokyo-night"' ]
    fi
done

for content in 'theme = 3' 'theme = "unfinished' '"theme" = "gruvbox"' \
    'theme = """multiline"""' '[radio] # unsupported section comment'; do
    printf '%s\n' "$content" > "$config"
    cp "$config" "$test_root/original"
    refuse_configuration
    cmp "$test_root/original" "$config"
done
printf 'theme = "gruvbox"\ntheme = "nord"\n' > "$config"
cp "$config" "$test_root/original"
refuse_configuration
cmp "$test_root/original" "$config"

rm "$config"
ln -s "$CLIAMP_CONFIG_DIR/config.toml" "$config"
refuse_configuration
[ -L "$config" ]
grep -Fx untouched "$CLIAMP_CONFIG_DIR/config.toml" >/dev/null
rm "$config"
ln -s "$test_root/missing" "$config"
refuse_configuration
[ ! -e "$test_root/missing" ]
rm "$config"
mkdir "$config"
refuse_configuration
rmdir "$config"
example="$destination/.config/cliamp/config.toml.example"
rm "$example"
ln -s "$CLIAMP_CONFIG_DIR/config.toml" "$example"
refuse_configuration
rm "$example"
mv "$destination/.config/cliamp" "$test_root/saved-cliamp"
ln -s "$test_root/saved-cliamp" "$destination/.config/cliamp"
refuse_configuration
rm "$destination/.config/cliamp"
mv "$test_root/saved-cliamp" "$destination/.config/cliamp"
mv "$destination/.config" "$test_root/saved-config"
ln -s "$test_root/saved-config" "$destination/.config"
refuse_configuration
rm "$destination/.config"
mv "$test_root/saved-config" "$destination/.config"
configure

# Relocate only the fixed system destination in a test copy, never on the host.
mkdir -p "$test_root/mock-bin" "$test_root/system" "$test_root/tmp"
sed "s|/usr/local/bin/cliamp|$test_root/system/cliamp|g" \
    "$feature/install/ubuntu.sh" > "$test_root/ubuntu.sh"
export MOCK_LOG="$test_root/commands" MOCK_SYSTEM="$test_root/system/cliamp"
export MOCK_ARCH=arm64 MOCK_T64=1 MOCK_FAIL=none
export TMPDIR="$test_root/tmp"
real_install=$(command -v install)
export REAL_INSTALL="$real_install"
cat > "$test_root/mock-bin/uname" <<'MOCK'
#!/bin/sh
printf '%s\n' "$MOCK_ARCH"
MOCK
cat > "$test_root/mock-bin/sudo" <<'MOCK'
#!/bin/sh
exec "$@"
MOCK
cat > "$test_root/mock-bin/apt" <<'MOCK'
#!/bin/sh
printf 'apt %s\n' "$*" >> "$MOCK_LOG"
[ "$MOCK_FAIL" != apt ]
MOCK
cat > "$test_root/mock-bin/apt-cache" <<'MOCK'
#!/bin/sh
[ "$MOCK_T64" = 1 ]
MOCK
cat > "$test_root/mock-bin/curl" <<'MOCK'
#!/bin/sh
printf 'curl %s\n' "$*" >> "$MOCK_LOG"
while [ "$1" != -o ]; do shift; done
printf '#!/bin/sh\n[ "$MOCK_FAIL" != runtime ]\n' > "$2"
[ "$MOCK_FAIL" != curl ]
MOCK
cat > "$test_root/mock-bin/sha256sum" <<'MOCK'
#!/bin/sh
cat >> "$MOCK_LOG"
[ "$MOCK_FAIL" != checksum ]
MOCK
cat > "$test_root/mock-bin/install" <<'MOCK'
#!/bin/sh
[ "$4" = "$MOCK_SYSTEM" ] || exit 90
printf 'install %s\n' "$*" >> "$MOCK_LOG"
[ "$MOCK_FAIL" != install ] || exit 1
exec "$REAL_INSTALL" "$@"
MOCK
cat > "$test_root/mock-bin/brew" <<'MOCK'
#!/bin/sh
printf 'brew %s\n' "$*" >> "$MOCK_LOG"
[ "$MOCK_FAIL" != brew ]
MOCK
for tool in ffmpeg yt-dlp cliamp; do
    cat > "$test_root/mock-bin/$tool" <<'MOCK'
#!/bin/sh
printf '%s %s\n' "${0##*/}" "$*" >> "$MOCK_LOG"
[ "$MOCK_FAIL" != runtime ]
MOCK
done
chmod +x "$test_root/mock-bin/"*
mock_path="$test_root/mock-bin:$PATH"

installer() {
    PATH="$mock_path" sh "$test_root/ubuntu.sh" > "$test_root/install.log" 2>&1 ||
        { cat "$test_root/install.log" >&2; fail installer; }
    [ -z "$(find "$TMPDIR" -mindepth 1 -print)" ] || fail 'installer temporary files leaked'
}
refuse_installation() {
    if PATH="$mock_path" sh "$test_root/ubuntu.sh" > "$test_root/install.log" 2>&1; then
        fail "installer accepted $MOCK_FAIL / $MOCK_ARCH"
    fi
    [ -z "$(find "$TMPDIR" -mindepth 1 -print)" ] || fail 'failed installer leaked files'
}
for MOCK_ARCH in arm64 aarch64 amd64 x86_64; do
    export MOCK_ARCH
    : > "$MOCK_LOG"
    installer
    case "$MOCK_ARCH" in
        arm64|aarch64)
            grep '/v2.3.0/cliamp-linux-arm64 ' "$MOCK_LOG" >/dev/null
            grep '^827b4aa879feecab33ea621dc1460c60ffa765c210b5046d679ce5a4073d2b32 ' "$MOCK_LOG" >/dev/null
            ;;
        *)
            grep '/v2.3.0/cliamp-linux-amd64 ' "$MOCK_LOG" >/dev/null
            grep '^5c59b5380c5165b473c06148c108ee60a18a1f9961f8013e38b4a68ed5def641 ' "$MOCK_LOG" >/dev/null
            ;;
    esac
    grep 'apt install -y ca-certificates curl coreutils libasound2t64 ffmpeg yt-dlp' "$MOCK_LOG" >/dev/null
    : > "$MOCK_LOG"
    installer
    if grep '^install ' "$MOCK_LOG"; then fail 'identical binary reinstalled'; fi
    rm "$MOCK_SYSTEM"
done
export MOCK_T64=0
: > "$MOCK_LOG"
installer
grep 'apt install -y ca-certificates curl coreutils libasound2 ffmpeg yt-dlp' "$MOCK_LOG" >/dev/null
rm "$MOCK_SYSTEM"
for MOCK_FAIL in apt curl checksum runtime install; do
    export MOCK_FAIL
    refuse_installation
    [ ! -e "$MOCK_SYSTEM" ] || fail 'failed installation left a binary'
done
export MOCK_FAIL=none MOCK_ARCH=riscv64
: > "$MOCK_LOG"
refuse_installation
grep 'supported only' "$test_root/install.log" >/dev/null
[ ! -s "$MOCK_LOG" ] || fail 'unsupported architecture changed system'
export MOCK_ARCH=arm64
printf 'existing binary\n' > "$MOCK_SYSTEM"
refuse_installation
grep 'refusing to replace' "$test_root/install.log" >/dev/null
grep -Fx 'existing binary' "$MOCK_SYSTEM" >/dev/null
rm "$MOCK_SYSTEM"
ln -s "$test_root/missing" "$MOCK_SYSTEM"
refuse_installation
[ -L "$MOCK_SYSTEM" ]
rm "$MOCK_SYSTEM"
: > "$MOCK_LOG"
PATH="$mock_path" sh "$feature/install/macos.sh"
grep -Fx 'brew install bjarneo/cliamp/cliamp ffmpeg yt-dlp' "$MOCK_LOG" >/dev/null
export MOCK_FAIL=brew
if PATH="$mock_path" sh "$feature/install/macos.sh"; then fail 'brew failure ignored'; fi

printf 'PASS: cliamp configuration, preservation, installer contracts, and failure handling\n'
