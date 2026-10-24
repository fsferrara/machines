#!/usr/bin/env sh
set -eu

[ "$(uname -s)" = Linux ] || exit 0
destination=${1:?modern-unix: configuration destination is required}

for directory in "$destination" "$destination/.local" "$destination/.local/bin"; do
    if [ -L "$directory" ]; then
        printf 'modern-unix: refusing to create command links through symlink: %s\n' "$directory" >&2
        exit 1
    fi
done

for pair in bat:batcat fd:fdfind; do
    name=${pair%:*}
    packaged=${pair#*:}
    link="$destination/.local/bin/$name"
    if ! target=$(command -v "$packaged"); then
        printf 'modern-unix: missing Ubuntu command %s; install the feature before configuring it.\n' "$packaged" >&2
        exit 1
    fi
    if [ -L "$link" ] && [ "$(readlink "$link")" = "$target" ]; then
        continue
    fi
    if [ -e "$link" ] || [ -L "$link" ]; then
        printf 'modern-unix: preserving conflicting command %s; resolve it explicitly before configuring.\n' "$link" >&2
        exit 1
    fi
    if existing=$(command -v "$name"); then
        # A link in another configured home does not provision this destination.
        if [ ! -L "$existing" ] || [ "$(readlink "$existing")" != "$target" ]; then
            continue
        fi
    fi
    mkdir -p "$destination/.local/bin"
    ln -s "$target" "$link"
done
