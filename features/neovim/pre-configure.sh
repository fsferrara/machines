#! /usr/bin/env sh

set -e
set -u


fail() {
    printf 'Neovim reset refused: %s\n' "$*" >&2
    exit 1
}

DESTINATION=${1-${HOME}}
[ -n "$DESTINATION" ] || fail "empty destination"
while [ "$DESTINATION" != / ] && [ "${DESTINATION%/}" != "$DESTINATION" ]; do
    DESTINATION=${DESTINATION%/}
done
[ -d "$DESTINATION" ] || fail "destination must be an existing directory"
[ ! -L "$DESTINATION" ] || fail "destination is a symlink"
DESTINATION=$(CDPATH= cd -- "$DESTINATION" && pwd -P)
REPO=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd -P)
case "$DESTINATION" in
    /|/Users|/home|"$REPO"|"$REPO"/*) fail "unsafe destination: $DESTINATION" ;;
esac

# Validate all parents before resetting any target or letting rsync follow a link.
for relative in .config .local .local/share .local/state .cache \
    .config/nvim .local/share/nvim .local/state/nvim .cache/nvim; do
    target="$DESTINATION/$relative"
    [ ! -L "$target" ] || fail "symlink at $target"
    if [ -e "$target" ] && [ ! -d "$target" ]; then
        fail "not a directory: $target"
    fi
done

printf 'Resetting Neovim configuration, plugins, state and cache under %s (no backup).\n' "$DESTINATION"
rm -rf -- "$DESTINATION/.config/nvim" "$DESTINATION/.local/share/nvim" \
    "$DESTINATION/.local/state/nvim" "$DESTINATION/.cache/nvim"


exit 0
