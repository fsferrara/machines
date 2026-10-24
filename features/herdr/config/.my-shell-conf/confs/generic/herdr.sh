alias h='herdr'

_herdr_run() {
	command herdr "$@" || {
		printf 'Error: herdr %s failed; any partial layout has been left intact.\n' "$1" >&2
		return 1
	}
}

_herdr_json() (
	filter=$1
	shift
	response=$(_herdr_run "$@") || return 1
	printf '%s\n' "$response" | jq -ers '
		if length == 1 and (.[0] | type == "object" and .error == null and
			(.result | type == "object"))
		then .[0] | '"$filter"'
		else error("expected one successful Herdr response") end
	' || {
		printf 'Error: invalid Herdr response for %s; any partial layout has been left intact.\n' "$1" >&2
		return 1
	}
)

_herdr_context() (
	for dependency in herdr jq; do
		command -v "$dependency" >/dev/null 2>&1 || {
			printf 'Error: Herdr layouts require %s.\n' "$dependency" >&2
			return 1
		}
	done
	if [ "${HERDR_ENV:-}" != 1 ] || [ -z "${HERDR_PANE_ID:-}" ] ||
		[ -z "${HERDR_TAB_ID:-}" ] || [ -z "${HERDR_WORKSPACE_ID:-}" ]; then
		printf 'Error: layouts must be run from a pane inside Herdr.\n' >&2
		return 1
	fi
	pane=$(_herdr_json '.result.pane | select(type == "object")' pane get "$HERDR_PANE_ID") || return 1
	printf '%s\n' "$pane" | jq -e --arg pane "$HERDR_PANE_ID" \
		--arg tab "$HERDR_TAB_ID" --arg workspace "$HERDR_WORKSPACE_ID" \
		'.pane_id == $pane and .tab_id == $tab and .workspace_id == $workspace' >/dev/null || {
		printf 'Error: Herdr pane, tab, and workspace context do not match.\n' >&2
		return 1
	}
	tab=$(_herdr_json '.result.tab | select(type == "object")' tab get "$HERDR_TAB_ID") || return 1
	printf '%s\n' "$tab" | jq -e --arg tab "$HERDR_TAB_ID" \
		--arg workspace "$HERDR_WORKSPACE_ID" \
		'.tab_id == $tab and .workspace_id == $workspace and .pane_count == 1' >/dev/null || {
		printf 'Error: layouts require a single-pane starting tab in the current workspace.\n' >&2
		return 1
	}
)

_herdr_quote() {
	printf "'"
	printf '%s' "$1" | sed "s/'/'\\\\''/g"
	printf "'"
}

_herdr_split() {
	_herdr_json '.result.pane.pane_id | select(type == "string" and test("^[^[:space:]]+$"))' \
		pane split "$1" --direction "$2" --ratio "$3" --cwd "$4" --no-focus
}

_herdr_tab_action() {
	_herdr_json '.result.tab.tab_id | select(type == "string" and length > 0)' tab "$@" >/dev/null
}

_herdr_dev_layout() (
	pane=$1 tab=$2 directory=$3 layout=$4 first_command=$5 second_command=$6
	_herdr_tab_action rename "$tab" "${directory##*/}" || return 1
	if [ "$layout" = hds ]; then
		bottom=$(_herdr_split "$pane" down 0.5 "$directory") || return 1
		right=$(_herdr_split "$pane" right 0.5 "$directory") || return 1
		second=$(_herdr_split "$bottom" right 0.5 "$directory") || return 1
	else
		_herdr_split "$pane" down 0.85 "$directory" >/dev/null || return 1
		right=$(_herdr_split "$pane" right 0.7 "$directory") || return 1
		if [ -n "$second_command" ]; then
			second=$(_herdr_split "$right" down 0.5 "$directory") || return 1
		fi
	fi
	_herdr_run pane run "$right" "$first_command" || return 1
	if [ -n "$second_command" ]; then
		_herdr_run pane run "$second" "$second_command" || return 1
	fi
	# The first tab in hdlm starts in the parent directory.
	_herdr_run pane run "$pane" "cd -- $(_herdr_quote "$directory") && ${EDITOR:-vi} ." || return 1
)

_herdr_development() (
	layout=$1
	shift
	if { [ "$layout" = hds ] && [ "$#" -ne 2 ]; } ||
		[ "$#" -lt 1 ] || [ "$#" -gt 2 ] ||
		[ -z "${1:-}" ] || { [ "$#" -eq 2 ] && [ -z "$2" ]; }; then
		if [ "$layout" = hds ]; then
			printf 'Usage: hds <diff-command> <agent-command>\n' >&2
		else
			printf 'Usage: %s <command> [second-command]\n' "$layout" >&2
		fi
		return 1
	fi
	_herdr_context || return 1
	if [ "$layout" != hdlm ]; then
		_herdr_dev_layout "$HERDR_PANE_ID" "$HERDR_TAB_ID" "$PWD" "$layout" "$1" "${2:-}"
		return $?
	fi
	if [ -n "${ZSH_VERSION:-}" ]; then
		setopt localoptions nonomatch
	fi
	found=
	for directory in "$PWD"/*/; do
		[ -d "$directory" ] || continue
		found=yes
		break
	done
	if [ -z "$found" ]; then
		printf 'Error: hdlm requires at least one immediate non-hidden subdirectory.\n' >&2
		return 1
	fi
	_herdr_json '.result.workspace.workspace_id | select(type == "string" and length > 0)' \
		workspace rename "$HERDR_WORKSPACE_ID" "${PWD##*/}" >/dev/null || return 1
	first=yes
	for directory in "$PWD"/*/; do
		[ -d "$directory" ] || continue
		directory=${directory%/}
		if [ "$first" = yes ]; then
			pane=$HERDR_PANE_ID tab=$HERDR_TAB_ID
			first=no
		else
			created=$(_herdr_json '.result | select(
				(.root_pane.pane_id | type == "string" and length > 0) and
				(.tab.tab_id | type == "string" and length > 0) and
				.root_pane.tab_id == .tab.tab_id)' \
				tab create --workspace "$HERDR_WORKSPACE_ID" --cwd "$directory" --no-focus) || return 1
			pane=$(printf '%s\n' "$created" | jq -r '.root_pane.pane_id')
			tab=$(printf '%s\n' "$created" | jq -r '.tab.tab_id')
		fi
		_herdr_dev_layout "$pane" "$tab" "$directory" hdl "$1" "${2:-}" || return 1
	done
	_herdr_tab_action focus "$HERDR_TAB_ID"
)

hdl() { _herdr_development hdl "$@"; }
hds() { _herdr_development hds "$@"; }
hdlm() { _herdr_development hdlm "$@"; }

hsl() (
	if [ "$#" -ne 2 ] || [ -z "${2:-}" ]; then
		printf 'Usage: hsl <positive-pane-count> <command>\n' >&2
		return 1
	fi
	case "$1" in
		''|*[!0-9]*)
			printf 'Error: pane count must be a positive integer.\n' >&2
			return 1 ;;
	esac
	count=$1
	while [ "${count#0}" != "$count" ]; do count=${count#0}; done
	if [ -z "$count" ] || [ "${#count}" -gt 10 ] ||
		{ [ "${#count}" -eq 10 ] && [ "$count" -gt 2147483647 ]; }; then
		printf 'Error: pane count must be between 1 and 2147483647.\n' >&2
		return 1
	fi
	_herdr_context || return 1
	_herdr_tab_action rename "$HERDR_TAB_ID" "${PWD##*/}" || return 1
	cols=1
	# Division avoids squaring past the portable signed-integer limit.
	while [ "$cols" -lt "$((count / cols))" ] ||
		{ [ "$cols" -eq "$((count / cols))" ] && [ "$((count % cols))" -ne 0 ]; }; do
		cols=$((cols + 1))
	done
	columns=$HERDR_PANE_ID
	last=$HERDR_PANE_ID
	index=1
	while [ "$index" -lt "$cols" ]; do
		# ratio is the retained pane's share, not the new pane's share.
		ratio=$(LC_ALL=C awk -v remaining="$((cols - index + 1))" 'BEGIN { printf "%.8f", 1 / remaining }')
		last=$(_herdr_split "$last" right "$ratio" "$PWD") || return 1
		columns="$columns $last"
		index=$((index + 1))
	done
	panes=
	index=0
	while [ -n "$columns" ]; do
		column=${columns%% *}
		rows=$((count / cols))
		if [ "$index" -lt "$((count % cols))" ]; then rows=$((rows + 1)); fi
		panes="${panes:+$panes }$column"
		last=$column
		row=1
		while [ "$row" -lt "$rows" ]; do
			ratio=$(LC_ALL=C awk -v remaining="$((rows - row + 1))" 'BEGIN { printf "%.8f", 1 / remaining }')
			last=$(_herdr_split "$last" down "$ratio" "$PWD") || return 1
			panes="$panes $last"
			row=$((row + 1))
		done
		index=$((index + 1))
		if [ "$columns" = "$column" ]; then break; fi
		columns=${columns#* }
	done
	while [ -n "$panes" ]; do
		pane=${panes%% *}
		_herdr_run pane run "$pane" "$2" || return 1
		if [ "$panes" = "$pane" ]; then break; fi
		panes=${panes#* }
	done
)
