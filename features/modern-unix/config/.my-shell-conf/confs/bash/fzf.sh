if ! command -v fzf >/dev/null 2>&1; then
    printf 'modern-unix: fzf is required for Bash integration.\n' >&2
    return 1
fi
if ! _modern_unix_fzf_init=$(fzf --bash); then
    printf 'modern-unix: could not initialize fzf; version >= 0.48 is required.\n' >&2
    unset _modern_unix_fzf_init
    return 1
fi
if ! eval "$_modern_unix_fzf_init"; then
    printf 'modern-unix: loading fzf Bash integration failed.\n' >&2
    unset _modern_unix_fzf_init
    return 1
fi
unset _modern_unix_fzf_init
