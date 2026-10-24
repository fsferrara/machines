#!/usr/bin/env bash
set -euo pipefail

feature=$(cd "$(dirname "$0")/.." && pwd)
repo=$(cd "$feature/../.." && pwd)
for tool in bash zsh jq rsync herdr; do
	command -v "$tool" >/dev/null || { printf 'Missing test dependency: %s\n' "$tool" >&2; exit 1; }
done
real_herdr=$(command -v herdr)
bash -n "$feature/config/.my-shell-conf/confs/generic/herdr.sh"
zsh -n "$feature/config/.my-shell-conf/confs/generic/herdr.sh"
cmp "$repo/core/install.sh" "$feature/install.sh"
cmp "$repo/core/configure.sh" "$feature/configure.sh"
jq -e '.dependsOn["./core"] == {}' "$feature/devcontainer-feature.json" >/dev/null
HERDR_CONFIG_PATH="$feature/config/.config/herdr/config.toml" herdr config check

test_home=
server_pid=
cleanup() {
	if [ -n "$server_pid" ]; then
		kill "$server_pid"
		wait "$server_pid" || [ "$?" -eq 143 ]
		server_pid=
	fi
	if [ -n "$test_home" ]; then
		case "$test_home" in /tmp/hd-test.??????) ;; *) printf 'Unsafe cleanup path: %s\n' "$test_home" >&2; return 1 ;; esac
		# Remove only the mktemp-owned tree, without traversing symlinks.
		find "$test_home" -depth -delete
		test_home=
	fi
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM

for test_shell in bash zsh; do
	test_home=$(mktemp -d /tmp/hd-test.XXXXXX)
	export HOME=$test_home XDG_CONFIG_HOME=$test_home/.config
	export XDG_CACHE_HOME=$test_home/.cache XDG_STATE_HOME=$test_home/.state
	export XDG_DATA_HOME=$test_home/.local/share XDG_RUNTIME_DIR=$test_home/runtime
	unset HERDR_SOCKET_PATH HERDR_PANE_ID HERDR_TAB_ID HERDR_WORKSPACE_ID HERDR_ENV
	export HERDR_SESSION=test HERDR_CONFIG_PATH=$test_home/.config/herdr/config.toml
	export HERDR_TEST_FEATURE=$feature HERDR_TEST_REAL=$real_herdr
	export HERDR_TEST_MARKERS=$test_home/markers
	export SHELL
	SHELL=$(command -v "$test_shell")
	mkdir -p "$test_home/runtime" "$test_home/markers" "$test_home/bin" "$test_home/fault-bin"
	cp "$feature/tests/editor" "$test_home/bin/editor"
	cp "$feature/tests/editor" "$test_home/bin/vi"
	cp "$feature/tests/herdr-fault" "$test_home/fault-bin/herdr"
	chmod +x "$test_home/bin/editor" "$test_home/bin/vi" "$test_home/fault-bin/herdr"
	export PATH="$test_home/bin:$PATH"
	export EDITOR="$test_home/bin/editor --fixture"
	mkdir -p "$test_home/.my-shell-conf/confs/generic"
	cp "$repo/core/config/.my-shell-conf/kickstart.sh" "$test_home/.my-shell-conf/"
	cp "$repo/features/tmux/config/.my-shell-conf/confs/generic/tmux.sh" \
		"$test_home/.my-shell-conf/confs/generic/"
	cp "$feature/tests/startup.sh" "$test_home/.bash_profile"
	cp "$feature/tests/startup.sh" "$test_home/.bashrc"
	cp "$feature/tests/startup.sh" "$test_home/.zshrc"
	printf 'preserve\n' > "$test_home/unrelated"
	ln -s "$test_home/unrelated" "$test_home/.my-shell-conf/confs/generic/other-link"
	"$feature/configure.sh" "$test_home" > "$test_home/configure.log"
	"$feature/configure.sh" "$test_home" >> "$test_home/configure.log"
	cmp "$feature/config/.config/herdr/config.toml" "$HERDR_CONFIG_PATH"
	cmp "$feature/config/.my-shell-conf/confs/generic/herdr.sh" \
		"$test_home/.my-shell-conf/confs/generic/herdr.sh"
	cmp "$repo/features/tmux/config/.my-shell-conf/confs/generic/tmux.sh" \
		"$test_home/.my-shell-conf/confs/generic/tmux.sh"
	[ "$(cat "$test_home/unrelated")" = preserve ]
	[ -L "$test_home/.my-shell-conf/confs/generic/other-link" ]
	herdr config check
	"$SHELL" -ic 'h --version && command -v hdl && command -v tdl' > "$test_home/shell.log" 2>&1
	herdr --session test server > "$test_home/server.log" 2>&1 &
	server_pid=$!
	for ((attempt = 0; attempt < 100; attempt++)); do
		if herdr --session test api snapshot > "$test_home/ready.json" 2>/dev/null; then break; fi
		if ! kill -0 "$server_pid" 2>/dev/null; then cat "$test_home/server.log" >&2; exit 1; fi
		sleep 0.1
	done
	jq -e '.result.snapshot.workspaces == []' "$test_home/ready.json" >/dev/null
	export HERDR_SOCKET_PATH=$test_home/.config/herdr/sessions/test/herdr.sock
	[ -S "$HERDR_SOCKET_PATH" ]
	"$SHELL" "$feature/tests/layouts.sh"
	printf 'PASS: %s / %s / %s\n' "$(uname -s)" "$test_shell" "$(herdr --version)"
	cleanup
done
