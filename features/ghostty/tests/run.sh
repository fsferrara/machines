#!/usr/bin/env bash
set -euo pipefail

feature=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$feature/../.." && pwd)
ghostty=${GHOSTTY_BIN:-ghostty}
for tool in "$ghostty" jq rsync; do
	command -v "$tool" >/dev/null || { printf 'Missing test dependency: %s\n' "$tool" >&2; exit 1; }
done
ghostty=$(command -v "$ghostty")

fail() {
	printf 'FAIL: %s\n' "$*" >&2
	exit 1
}

for installer in "$feature/install/macos.sh" "$feature/install/ubuntu.sh"; do
	sh -n "$installer"
done
bash -n "$repo/features/nerdfonts/install/install.sh"
cmp "$repo/core/install.sh" "$feature/install.sh"
cmp "$repo/core/configure.sh" "$feature/configure.sh"
jq -e '.id == "ghostty" and .name == "my feature ghostty"
	and .dependsOn["./core"] == {}
	and .dependsOn["./features/nerdfonts"] == {}' \
	"$feature/devcontainer-feature.json" >/dev/null
grep -Fx '"${HOME}/.local/bin/getnf" -i JetBrainsMono' \
	"$repo/features/nerdfonts/install/install.sh" >/dev/null

test_home=$(mktemp -d /tmp/ghostty-test.XXXXXX)
cleanup() {
	case "$test_home" in /tmp/ghostty-test.??????) ;; *) printf 'Unsafe cleanup path: %s\n' "$test_home" >&2; return 1 ;; esac
	find "$test_home" -depth -delete
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM
export HOME=$test_home XDG_CONFIG_HOME=$test_home/.config
export XDG_DATA_HOME=$test_home/.local/share XDG_CACHE_HOME=$test_home/.cache
export XDG_STATE_HOME=$test_home/.local/state
config=$XDG_CONFIG_HOME/ghostty/config
mkdir -p "$XDG_CONFIG_HOME/ghostty" "$HOME/.my-shell-conf/confs/generic"
printf 'preserve\n' > "$XDG_CONFIG_HOME/ghostty/local-notes"
ln -s local-notes "$XDG_CONFIG_HOME/ghostty/local-link"
cp "$repo/features/tmux/config/.my-shell-conf/confs/generic/tmux.sh" \
	"$HOME/.my-shell-conf/confs/generic/"
cp "$repo/features/herdr/config/.my-shell-conf/confs/generic/herdr.sh" \
	"$HOME/.my-shell-conf/confs/generic/"

for attempt in 1 2; do
	"$feature/configure.sh" "$HOME" > "$HOME/configure.log"
	cmp "$feature/config/.config/ghostty/config" "$config"
	[ "$(cat "$XDG_CONFIG_HOME/ghostty/local-notes")" = preserve ]
	[ "$(readlink "$XDG_CONFIG_HOME/ghostty/local-link")" = local-notes ]
	for module in tmux herdr; do
		cmp "$repo/features/$module/config/.my-shell-conf/confs/generic/$module.sh" \
			"$HOME/.my-shell-conf/confs/generic/$module.sh"
	done
	"$ghostty" +validate-config --config-file="$config" > "$HOME/validation.log" 2>&1 ||
		{ cat "$HOME/validation.log" >&2; fail "configuration validation (pass $attempt)"; }
	[ ! -s "$HOME/validation.log" ] ||
		{ cat "$HOME/validation.log" >&2; fail 'unexpected validation diagnostics'; }
done

"$ghostty" +show-config --changes-only=false > "$HOME/effective" 2> "$HOME/show.log" ||
	{ cat "$HOME/show.log" >&2; fail 'loading effective configuration'; }
[ ! -s "$HOME/show.log" ] ||
	{ cat "$HOME/show.log" >&2; fail 'unexpected configuration diagnostics'; }

assert_line() {
	grep -Fx -- "$1" "$HOME/effective" >/dev/null || fail "missing effective setting: $1"
}

while IFS= read -r setting; do
	assert_line "$setting"
done <<'SETTINGS'
font-family = JetBrainsMono Nerd Font
font-style = Regular
font-size = 9
background = #1a1b26
foreground = #a9b1d6
selection-background = #292e42
selection-foreground = #c0caf5
cursor-color = #c0caf5
cursor-style = block
cursor-style-blink = false
window-theme = ghostty
window-padding-x = 14
window-padding-y = 14
confirm-close-surface = false
resize-overlay = never
scrollbar = never
scrollback-limit = 10000
mouse-scroll-multiplier = precision:0.95,discrete:0.95
mouse-reporting = true
mouse-shift-capture = false
shell-integration = detect
shell-integration-features = no-cursor,no-sudo,title,ssh-env,no-ssh-terminfo,path
term = xterm-ghostty
keybind = ctrl+shift+n=new_window
keybind = ctrl+shift+t=new_tab
keybind = shift+insert=paste_from_clipboard
keybind = ctrl+insert=copy_to_clipboard:mixed
keybind = shift+enter=csi:13;2u
keybind = alt+shift+enter=csi:13;4u
SETTINGS

for direction in up down left right; do
	assert_line "keybind = super+ctrl+alt+shift+arrow_$direction=resize_split:$direction,100"
done
for ((index = 0; index < 16; index++)); do
	color=$(grep "^palette = $index=" "$config")
	assert_line "$color"
done
if [ "$(uname -s)" = Darwin ]; then
	assert_line 'macos-option-as-alt = true'
fi
if grep -E '^keybind = (ctrl\+space|alt\+enter|alt\+arrow_(left|right))=' "$HOME/effective"; then
	fail 'terminal intercepts multiplexer keys'
fi
if grep -E '^[[:space:]]*(config-file|theme|gtk-[^ =]*|async-backend|window-subtitle|command|term)[[:space:]]*=|/omarchy/' "$config"; then
	fail 'unexpected platform-specific configuration or runtime dependency'
fi

printf 'background = not-a-color\n' > "$HOME/invalid"
if "$ghostty" +validate-config --config-file="$HOME/invalid" > "$HOME/invalid.log" 2>&1; then
	fail 'invalid configuration was accepted'
fi
[ -s "$HOME/invalid.log" ] || fail 'invalid configuration produced no diagnostics'

printf 'PASS: Ghostty configuration, effective settings, repeatability, and preservation (%s)\n' "$(uname -s)"
"$ghostty" +version
