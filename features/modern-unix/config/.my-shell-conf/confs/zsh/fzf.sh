if ! command -v fzf >/dev/null 2>&1; then
    printf 'modern-unix: fzf is required for Zsh integration.\n' >&2
    return 1
fi
if ! typeset -f compdef >/dev/null; then
    autoload -Uz compinit
    if ! compinit; then
        printf 'modern-unix: could not initialize Zsh completion.\n' >&2
        return 1
    fi
fi
if ! _modern_unix_fzf_init=$(fzf --zsh); then
    printf 'modern-unix: could not initialize fzf; version >= 0.48 is required.\n' >&2
    unset _modern_unix_fzf_init
    return 1
fi
if ! eval "$_modern_unix_fzf_init"; then
    printf 'modern-unix: loading fzf Zsh integration failed.\n' >&2
    unset _modern_unix_fzf_init
    return 1
fi
unset _modern_unix_fzf_init
