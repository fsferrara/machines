export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---color=base16}"

ff() {
    if ! command -v fzf >/dev/null 2>&1 || ! command -v bat >/dev/null 2>&1; then
        printf 'modern-unix: ff requires fzf and bat.\n' >&2
        return 1
    fi
    fzf --preview 'bat --style=numbers --color=always -- {}' "$@"
}
