if ! command -v zoxide >/dev/null 2>&1; then
    printf 'modern-unix: zoxide is required for Zsh integration.\n' >&2
    return 1
fi
if ! _modern_unix_zoxide_init=$(zoxide init zsh); then
    printf 'modern-unix: could not initialize zoxide for Zsh.\n' >&2
    unset _modern_unix_zoxide_init
    return 1
fi
if ! eval "$_modern_unix_zoxide_init"; then
    printf 'modern-unix: loading zoxide Zsh integration failed.\n' >&2
    unset _modern_unix_zoxide_init
    return 1
fi
unset _modern_unix_zoxide_init
