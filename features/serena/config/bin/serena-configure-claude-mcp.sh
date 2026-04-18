#! /usr/bin/env bash

set -e
set -u


###########
# ADD MCP #
###########
printf '\n\n🚀 Adding MCP...\n'
claude mcp add --scope user serena -- serena start-mcp-server --context claude-code --project-from-cwd

printf '\n\n🚀 Adding Hooks...\n'
## multiline string in a variable
HOOKS=$(cat <<EOF
{
    "hooks": {
        "PreToolUse": [
            {
                "matcher": "",
                "hooks": [
                    {
                        "type": "command",
                        "command": "serena-hooks remind --client=claude-code"
                    }
                ]
            },
            {
                "matcher": "mcp__serena__*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "serena-hooks auto-approve --client=claude-code"
                    }
                ]
            }
        ],
        "SessionStart": [
            {
                "matcher": "",
                "hooks": [
                    {
                        "type": "command",
                        "command": "serena-hooks activate --client=claude-code"
                    }
                ]
            }
        ],
        "Stop": [
            {
                "matcher": "",
                "hooks": [
                    {
                        "type": "command",
                        "command": "serena-hooks cleanup --client=claude-code"
                    }
                ]
            }
        ]
    }
}
EOF
)

printf '\n\n💡 Remember to add the hooks to ~/.claude/settings.json\n'
printf '\n\n%s\n' "$HOOKS"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
