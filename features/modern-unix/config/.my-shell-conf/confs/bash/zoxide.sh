if ! command -v zoxide >/dev/null 2>&1; then
    printf 'modern-unix: zoxide is required for Bash integration.\n' >&2
    return 1
fi
if ! _modern_unix_zoxide_init=$(zoxide init bash); then
    printf 'modern-unix: could not initialize zoxide for Bash.\n' >&2
    unset _modern_unix_zoxide_init
    return 1
fi
if ! eval "$_modern_unix_zoxide_init"; then
    printf 'modern-unix: loading zoxide Bash integration failed.\n' >&2
    unset _modern_unix_zoxide_init
    return 1
fi
unset _modern_unix_zoxide_init
