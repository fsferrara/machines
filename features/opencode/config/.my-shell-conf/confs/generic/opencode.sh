################################################################################
# OPENCODE CONFIGURATION
################################################################################
OPENCODE_CONFIG_EXPECTED_DIR="$HOME/.config/opencode/host-specific"
OPENCODE_CONFIG_EXPECTED_FILE="$OPENCODE_CONFIG_EXPECTED_DIR/opencode.json"

if [ -d "$OPENCODE_CONFIG_EXPECTED_DIR" ] && [ -f "$OPENCODE_CONFIG_EXPECTED_FILE" ]; then
    export OPENCODE_CONFIG="$OPENCODE_CONFIG_EXPECTED_FILE"
fi
