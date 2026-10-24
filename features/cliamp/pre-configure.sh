#! /usr/bin/env sh

set -eu

fail() {
    printf 'cliamp: %s\n' "$*" >&2
    exit 1
}

destination=${1:-$HOME}
while [ "$destination" != / ] && [ "${destination%/}" != "$destination" ]; do
    destination=${destination%/}
done
[ ! -L "$destination" ] || fail "destination is a symlink: $destination"
mkdir -p "$destination"
destination=$(CDPATH= cd -- "$destination" && pwd -P)
[ "$destination" != / ] || fail "refusing to configure the filesystem root"
for relative in .config .config/cliamp; do
    path="$destination/$relative"
    [ ! -L "$path" ] || fail "configuration directory is a symlink: $path"
    if [ -e "$path" ] && [ ! -d "$path" ]; then
        fail "configuration path is not a directory: $path"
    fi
done
directory="$destination/.config/cliamp"
for name in config.toml config.toml.example; do
    path="$directory/$name"
    [ ! -L "$path" ] || fail "configuration file is a symlink: $path"
    if [ -e "$path" ] && [ ! -f "$path" ]; then
        fail "configuration path is not a regular file: $path"
    fi
done

umask 077
mkdir -p "$directory"
config="$directory/config.toml"
temporary=$(mktemp "$directory/.machines-theme.XXXXXX")
trap 'rm -f "$temporary"' 0
trap 'exit 1' HUP INT TERM
if [ -f "$config" ]; then
    cp -p "$config" "$temporary"
    # Cliamp uses a line-oriented parser; reject syntax we cannot safely edit.
    if ! awk '
        function reject() { invalid = 1; exit 1 }
        /^[ \t]*#/ { print; next }
        /"""|\047\047\047/ { reject() }
        /^[ \t]*\[/ {
            if ($0 !~ /^[ \t]*\[[^][]+\][ \t]*$/) reject()
            if (!section && !found) print "theme = \"tokyo-night\""
            section = 1
        }
        !section && /^[ \t]*["\047]theme["\047][ \t]*=/ { reject() }
        !section && /^[ \t]*theme[ \t]*=/ {
            if (found++) reject()
            if ($0 !~ /^[ \t]*theme[ \t]*=[ \t]*("[^"]*"|\047[^\047]*\047)[ \t]*(#.*)?$/) reject()
            suffix = $0
            sub(/^[ \t]*theme[ \t]*=[ \t]*("[^"]*"|\047[^\047]*\047)/, "", suffix)
            prefix = $0
            sub(/=.*/, "= ", prefix)
            if (suffix ~ /#/) {
                indent = $0
                sub(/[^ \t].*/, "", indent)
                sub(/^[ \t]*/, "", suffix)
                print indent suffix
                suffix = ""
            }
            print prefix "\"tokyo-night\"" suffix
            next
        }
        { print }
        END {
            if (invalid) exit 1
            if (!section && !found) print "theme = \"tokyo-night\""
        }
    ' "$config" > "$temporary"; then
        fail "cannot safely update theme in $config (duplicate theme or unsupported syntax); original file preserved"
    fi
    if cmp -s "$config" "$temporary"; then
        exit 0
    fi
else
    printf 'theme = "tokyo-night"\n' > "$temporary"
fi
mv -f "$temporary" "$config"
