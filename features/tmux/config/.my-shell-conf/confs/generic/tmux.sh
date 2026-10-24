_tmux_run() {
	command tmux "$@" || {
		printf 'Error: tmux %s failed; any partial layout has been left intact.\n' "$1" >&2
		return 1
	}
}

t() {
	if [ "$#" -ne 0 ]; then
		printf 'Usage: t\n' >&2
		return 1
	fi
	if [ -n "${TMUX:-}" ]; then
		_tmux_run choose-tree -s
	else
		# One server command queue distinguishes no sessions from an attach error.
		_tmux_run start-server \; if-shell -F '#{session_name}' \
			attach-session 'new-session -s Work'
	fi
}

_tmux_layout_context() {
	if [ -z "${TMUX:-}" ] || [ -z "${TMUX_PANE:-}" ]; then
		printf 'Error: layouts must be run from a pane inside tmux.\n' >&2
		return 1
	fi
	if [ "$(_tmux_run display-message -p -t "$TMUX_PANE" '#{window_panes}')" != 1 ]; then
		printf 'Error: layouts require a single-pane starting window.\n' >&2
		return 1
	fi
}

_tmux_send() {
	_tmux_run send-keys -t "$1" -l -- "$2" &&
		_tmux_run send-keys -t "$1" Enter
}

_tmux_quote() {
	printf "'"
	printf '%s' "$1" | sed "s/'/'\\\\''/g"
	printf "'"
}

_tmux_dev_layout() (
	pane=$1 directory=$2 layout=$3 first_command=$4 second_command=$5
	_tmux_run rename-window -t "$pane" -- "${directory##*/}" || return 1
	if [ "$layout" = tds ]; then
		bottom=$(_tmux_run split-window -d -v -p 50 -t "$pane" -c "$directory" -P -F '#{pane_id}') || return 1
		right=$(_tmux_run split-window -d -h -p 50 -t "$pane" -c "$directory" -P -F '#{pane_id}') || return 1
		second=$(_tmux_run split-window -d -h -p 50 -t "$bottom" -c "$directory" -P -F '#{pane_id}') || return 1
	else
		_tmux_run split-window -d -v -p 15 -t "$pane" -c "$directory" || return 1
		right=$(_tmux_run split-window -d -h -p 30 -t "$pane" -c "$directory" -P -F '#{pane_id}') || return 1
		if [ -n "$second_command" ]; then
			second=$(_tmux_run split-window -d -v -p 50 -t "$right" -c "$directory" -P -F '#{pane_id}') || return 1
		fi
	fi
	_tmux_send "$right" "$first_command" || return 1
	if [ -n "$second_command" ]; then
		_tmux_send "$second" "$second_command" || return 1
	fi
	# The reused pane may still be in tdlm's parent directory.
	_tmux_send "$pane" "cd -- $(_tmux_quote "$directory") && ${EDITOR:-vi} ." || return 1
	_tmux_run select-pane -t "$pane"
)

_tmux_development() (
	layout=$1
	shift
	if { [ "$layout" = tds ] && [ "$#" -ne 2 ]; } ||
		[ "$#" -lt 1 ] || [ "$#" -gt 2 ] ||
		[ -z "${1:-}" ] || { [ "$#" -eq 2 ] && [ -z "$2" ]; }; then
		if [ "$layout" = tds ]; then
			printf 'Usage: tds <diff-command> <agent-command>\n' >&2
		else
			printf 'Usage: %s <command> [second-command]\n' "$layout" >&2
		fi
		return 1
	fi
	_tmux_layout_context || return 1
	if [ "$layout" != tdlm ]; then
		_tmux_dev_layout "$TMUX_PANE" "$PWD" "$layout" "$1" "${2:-}"
		return $?
	fi

	# Zsh otherwise errors on a glob without matches; keep the option local.
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
		printf 'Error: tdlm requires at least one immediate non-hidden subdirectory.\n' >&2
		return 1
	fi
	session=$(_tmux_run display-message -p -t "$TMUX_PANE" '#{session_id}') || return 1
	session_name=$(printf '%s' "${PWD##*/}" | tr '.:' '--')
	[ -n "$session_name" ] || session_name=Work
	_tmux_run rename-session -t "$session" -- "$session_name" || return 1
	first=yes
	for directory in "$PWD"/*/; do
		[ -d "$directory" ] || continue
		directory=${directory%/}
		if [ "$first" = yes ]; then
			pane=$TMUX_PANE
			first=no
		else
			pane=$(_tmux_run new-window -d -t "$session:" -c "$directory" -P -F '#{pane_id}') || return 1
		fi
		_tmux_dev_layout "$pane" "$directory" tdl "$1" "${2:-}" || return 1
	done
	_tmux_run select-window -t "$TMUX_PANE"
)

tdl() { _tmux_development tdl "$@"; }
tds() { _tmux_development tds "$@"; }
tdlm() { _tmux_development tdlm "$@"; }

tsl() (
	if [ "$#" -ne 2 ] || [ -z "${2:-}" ]; then
		printf 'Usage: tsl <positive-pane-count> <command>\n' >&2
		return 1
	fi
	case "$1" in
		''|*[!0-9]*)
			printf 'Error: pane count must be a positive integer.\n' >&2
			return 1 ;;
	esac
	count=$1
	while [ "${count#0}" != "$count" ]; do count=${count#0}; done
	# Stay within portable signed shell arithmetic, not an arbitrary layout cap.
	if [ -z "$count" ] || [ "${#count}" -gt 10 ] ||
		{ [ "${#count}" -eq 10 ] && [ "$count" -gt 2147483647 ]; }; then
		printf 'Error: pane count must be between 1 and 2147483647.\n' >&2
		return 1
	fi
	_tmux_layout_context || return 1
	_tmux_run rename-window -t "$TMUX_PANE" -- "${PWD##*/}" || return 1
	panes=$TMUX_PANE
	target=$TMUX_PANE
	index=1
	while [ "$index" -lt "$count" ]; do
		target=$(_tmux_run split-window -d -h -t "$target" -c "$PWD" -P -F '#{pane_id}') || return 1
		panes="$panes $target"
		_tmux_run select-layout -t "$TMUX_PANE" tiled || return 1
		index=$((index + 1))
	done
	# Explicit splitting also works with Zsh's default no-SH_WORD_SPLIT behavior.
	while [ -n "$panes" ]; do
		pane=${panes%% *}
		_tmux_send "$pane" "$2" || return 1
		if [ "$panes" = "$pane" ]; then break; fi
		panes=${panes#* }
	done
	_tmux_run select-pane -t "$TMUX_PANE"
)
