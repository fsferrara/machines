################################################################################
# TMUX
################################################################################

# Session management
_tmux_sessions_dir() {
	printf '%s\n' "${TMUX_SESSIONS_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/tmux/sessions.d}"
}

_tmux_has_session() {
	tmux has-session -t "=$1" 2>/dev/null
}

_tmux_validate_session_name() {
	case "$1" in
		'')
			printf 'Error: session name cannot be empty.\n' >&2
			return 1
			;;
		*[./:]*)
			printf 'Error: session name cannot contain periods, slashes, or colons: %s\n' "$1" >&2
			return 1
			;;
	esac
}

_tmux_connect_session() {
	if [ -n "${TMUX:-}" ]; then
		tmux switch-client -t "=$1"
	else
		tmux attach-session -t "=$1"
	fi
}

_tmux_create_configured_session() (
	session_name=$1
	session_file=$2

	TMUX_SESSION_DIRECTORY=
	TMUX_SESSION_COMMAND=
	unset -f tmux_session_create 2>/dev/null || true

	# shellcheck disable=SC1090
	. "$session_file"

	if [ -z "$TMUX_SESSION_DIRECTORY" ]; then
		printf 'Error: TMUX_SESSION_DIRECTORY is not set in %s.\n' "$session_file" >&2
		return 1
	fi

	if [ ! -d "$TMUX_SESSION_DIRECTORY" ]; then
		printf 'Error: session directory does not exist: %s\n' "$TMUX_SESSION_DIRECTORY" >&2
		return 1
	fi

	if command -v tmux_session_create >/dev/null 2>&1; then
		tmux_session_create "$session_name" "$TMUX_SESSION_DIRECTORY"
	elif [ -n "$TMUX_SESSION_COMMAND" ]; then
		tmux new-session -d -s "$session_name" -c "$TMUX_SESSION_DIRECTORY" \
			"$TMUX_SESSION_COMMAND; exec \"${SHELL:-/bin/sh}\""
	else
		tmux new-session -d -s "$session_name" -c "$TMUX_SESSION_DIRECTORY"
	fi

	if ! _tmux_has_session "$session_name"; then
		printf 'Error: session definition did not create session: %s\n' "$session_name" >&2
		return 1
	fi
)

unalias tmux-list tmux-attach tmux-new 2>/dev/null || true

_tmux_list() (
	sessions_dir=$(_tmux_sessions_dir)

	{
		tmux list-sessions -F '#S' 2>/dev/null || true

		for session_file in "$sessions_dir"/*.sh; do
			[ -f "$session_file" ] || continue
			session_name=${session_file##*/}
			printf '%s\n' "${session_name%.sh}"
		done
	} | awk 'NF && !seen[$0]++'
)

_tmux_new() (
	if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
		printf 'Usage: tmux-new <name> [directory]\n' >&2
		return 1
	fi

	session_name=$1
	session_directory=${2:-$PWD}

	_tmux_validate_session_name "$session_name" || return 1

	if [ ! -d "$session_directory" ]; then
		printf 'Error: session directory does not exist: %s\n' "$session_directory" >&2
		return 1
	fi

	if _tmux_has_session "$session_name"; then
		printf 'Error: tmux session already exists: %s\n' "$session_name" >&2
		return 1
	fi

	tmux new-session -d -s "$session_name" -c "$session_directory" || return 1
	_tmux_connect_session "$session_name"
)

_tmux_connect() (
	if [ "$#" -gt 1 ]; then
		printf 'Usage: tmux-connect [name]\n' >&2
		return 1
	fi

	if [ "$#" -eq 1 ]; then
		session_name=$1
	else
		session_name=$(_tmux_list | fzf --layout=reverse --prompt='tmux session> ') || return 0
		[ -n "$session_name" ] || return 0
	fi

	_tmux_validate_session_name "$session_name" || return 1

	if ! _tmux_has_session "$session_name"; then
		session_file="$(_tmux_sessions_dir)/$session_name.sh"

		if [ -f "$session_file" ]; then
			_tmux_create_configured_session "$session_name" "$session_file" || return 1
		else
			tmux new-session -d -s "$session_name" -c "$PWD" || return 1
		fi
	fi

	_tmux_connect_session "$session_name"
)

# Commands
alias tmux-list="_tmux_list"
alias tmux-connect="_tmux_connect"
alias tmux-attach="_tmux_connect"
alias tmux-new="_tmux_new"
alias tmux-new-detached="tmux new -d -s"
alias tmux-kill="tmux kill-session -t"
alias tmux-kill-all="tmux kill-server"

# Misc
export TERM="screen-256color"
