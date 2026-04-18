################################################################################
# OLLAMA CONFIGURATION
################################################################################

# Models
export OLLAMA_MODEL_DEFAULT=qwen3.6

# Bind to all interfaces
export OLLAMA_HOST=0.0.0.0

# Ollama default port
export OLLAMA_PORT=11434

# Options
export OLLAMA_FLASH_ATTENTION="1"
export OLLAMA_KV_CACHE_TYPE="q8_0"
