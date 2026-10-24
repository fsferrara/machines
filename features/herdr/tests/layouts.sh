set -eu
. "$HOME/.my-shell-conf/confs/generic/tmux.sh"
. "$HOME/.my-shell-conf/confs/generic/herdr.sh"
command -v tdl >/dev/null
command -v hdl >/dev/null
alias h | grep -Eq "^(alias )?h=('herdr'|herdr)$"

fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }
snapshot() { "$HERDR_TEST_REAL" api snapshot | jq '.result.snapshot'; }
assert_state() {
	snapshot | jq -e "$1" >/dev/null || fail "$1"
}
new_workspace() {
	created=$("$HERDR_TEST_REAL" workspace create --cwd "$PWD" --label test)
	export HERDR_ENV=1
	export HERDR_WORKSPACE_ID=$(printf '%s\n' "$created" | jq -r '.result.workspace.workspace_id')
	export HERDR_TAB_ID=$(printf '%s\n' "$created" | jq -r '.result.tab.tab_id')
	export HERDR_PANE_ID=$(printf '%s\n' "$created" | jq -r '.result.root_pane.pane_id')
}
close_workspace() {
	"$HERDR_TEST_REAL" workspace close "$HERDR_WORKSPACE_ID" >/dev/null
}
expect_failure() {
	if "$@" > "$HOME/failure.out" 2> "$HOME/failure.err"; then fail "unexpected success: $*"; fi
	[ -s "$HOME/failure.err" ] || fail "missing diagnostic: $*"
}
wait_markers() {
	expected=$1
	for attempt in $(seq 1 100); do
		found=$(find "$HERDR_TEST_MARKERS" -name "$HERDR_WORKSPACE_ID:p*" -type f | wc -l | tr -d ' ')
		[ "$found" -eq "$expected" ] && return 0
		sleep 0.1
	done
	fail "expected $expected markers, found $found"
}
wait_editor() {
	for attempt in $(seq 1 100); do
		[ -s "$HERDR_TEST_MARKERS/editor-$1" ] && return 0
		sleep 0.1
	done
	"$HERDR_TEST_REAL" pane read "$1" >&2
	fail "editor marker missing for $1"
}
assert_single() {
	assert_state '(.panes | length) == 1 and (.tabs | length) == 1'
}

mkdir -p "$HOME/project 'quoted' \$literal;"
cd "$HOME/project 'quoted' \$literal;"
project=$(pwd -P)
cd "$project"

for function in hdl hds hdlm hsl; do expect_failure "$function"; done
expect_failure hdl command
(
	unset HERDR_ENV
	expect_failure hsl 2147483647 true
	grep -q 'inside Herdr' "$HOME/failure.err" || fail 'valid maximum rejected as an invalid count'
)
new_workspace
for count in 0 000 -1 1.5 abc 2147483648 99999999999999999999999; do
	expect_failure hsl "$count" true
	assert_single
done
expect_failure hsl 1 ''
expect_failure hds true
expect_failure hdl true ''
expect_failure hdl true true true
expect_failure hdlm true
assert_single
(
	export HERDR_PANE_ID=stale
	expect_failure hdl true
)
(
	export HERDR_TAB_ID=stale
	expect_failure hdl true
)
(
	PATH=$HOME/no-tools
	expect_failure hdl true
)
for fault in invalid-json api-error stale-context; do
	(
		export PATH="$HOME/fault-bin:$PATH" HERDR_TEST_FAULT=$fault
		expect_failure hdl true
	)
	assert_single
done
close_workspace

for count in 1 2 3 5 8 0009; do
	new_workspace
	hsl "$count" fixture_marker
	decimal=$(printf '%s' "$count" | sed 's/^0*//')
	assert_state "(.panes | length) == $decimal"
	assert_state '.layouts[0] | .focused_pane_id == .panes[0].pane_id'
	assert_state '[.layouts[0].panes[].rect.width] | (max - min) <= 1'
	wait_markers "$decimal"
	for marker in "$HERDR_TEST_MARKERS/$HERDR_WORKSPACE_ID":p*; do
		[ "$(cat "$marker")" = "$project" ] || fail 'grid cwd'
	done
	if [ "$decimal" -gt 1 ]; then expect_failure hdl true; fi
	close_workspace
done

new_workspace
hdl fixture_marker
assert_state '(.panes | length) == 3'
assert_state '.layouts[0].splits | length == 2 and .[0].direction == "down" and
	.[0].ratio > 0.84 and .[0].ratio < 0.86 and .[1].ratio > 0.69 and .[1].ratio < 0.71'
wait_editor "$HERDR_PANE_ID"
wait_markers 1
[ "$(sed -n '1p' "$HERDR_TEST_MARKERS/editor-$HERDR_PANE_ID")" = "$project" ] || fail 'editor cwd'
grep -q '^--fixture$' "$HERDR_TEST_MARKERS/editor-$HERDR_PANE_ID" || fail 'editor arguments'
close_workspace

new_workspace
hdl fixture_marker fixture_marker
assert_state '(.panes | length) == 4'
wait_editor "$HERDR_PANE_ID"
wait_markers 2
close_workspace

new_workspace
(
	unset EDITOR
	hds fixture_marker fixture_marker
)
assert_state '(.panes | length) == 4'
assert_state 'all(.layouts[0].splits[]; .ratio == 0.5)'
wait_editor "$HERDR_PANE_ID"
[ "$(sed -n '2p' "$HERDR_TEST_MARKERS/editor-$HERDR_PANE_ID")" = . ] || fail 'vi fallback'
wait_markers 2
close_workspace

mkdir -p "$project/a 'one'" "$project/b \$two" "$project/.hidden"
new_workspace
hdlm fixture_marker
assert_state '(.tabs | length) == 2 and (.panes | length) == 6'
assert_state '.workspaces[0].active_tab_id == .tabs[0].tab_id'
wait_markers 2
for pane in $(snapshot | jq -r '.layouts[].focused_pane_id'); do wait_editor "$pane"; done
for marker in "$HERDR_TEST_MARKERS/$HERDR_WORKSPACE_ID":p*; do
	case "$(cat "$marker")" in "$project/a 'one'"|"$project/b \$two") ;; *) fail 'multi-project cwd' ;; esac
done
[ "$PWD" = "$project" ] || fail 'caller directory changed'
close_workspace

for fault in missing-id second-split; do
	new_workspace
	(
		export PATH="$HOME/fault-bin:$PATH" HERDR_TEST_FAULT=$fault
		expect_failure hdl fixture_marker
	)
	if [ "$fault" = missing-id ]; then assert_single
	else assert_state '(.panes | length) == 2'
	fi
	close_workspace
done
assert_state '(.workspaces | length) == 0'
