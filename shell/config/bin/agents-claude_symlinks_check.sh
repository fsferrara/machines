#!/usr/bin/env bash
set -e
set -u
set -o pipefail


echo "Verifying AGENTS.md files exist..."
find . -name "AGENTS.md" -type f

echo "Verifying CLAUDE.md symlinks..."
find . -name "CLAUDE.md" -type l

echo "Verifying CLAUDE.md symlinks point to AGENTS.md files..."
find . -name "CLAUDE.md" -type l -exec ls -la {} \;

echo "Verifying CLAUDE.md files do not contain agent-specific references..."
grep -r "Claude Code (claude.ai/code)" . --include="*.md" | grep AGENTS.md
echo "if there are reference to Claude Code (claude.ai/code) in AGENTS.md files, please remove them."
echo "use generic references to 'the AI agent' instead. For example:"
echo "This file provides guidance to AI agents when working with code in this repository."

echo ""
echo "✓ CLAUDE.md symlinks verification complete!"

echo "Make sure this note is added to the main AGENTS.md file:"
echo "**Note**: This project uses the open AGENTS.md standard. These files are symlinked to CLAUDE.md files in the same directory for interoperability with Claude Code. Any agent instructions or memory features should be saved to AGENTS.md files instead of CLAUDE.md files."


exit 0
