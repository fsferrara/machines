#!/usr/bin/env bash
set -e
set -u
set -o pipefail

# Remove all CLAUDE.md symlinks and recreate
find . -name "CLAUDE.md" -type l -delete

echo "✓ CLAUDE.md symlinks deleted!"

exit 0
