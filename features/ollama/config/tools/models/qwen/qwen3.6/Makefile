.DEFAULT_GOAL := default

MODEL ?= qwen
BASE_MODEL ?= qwen3.6
MODELFILE ?= Modelfile

OLLAMA_HOST ?= 0.0.0.0
OLLAMA_PORT ?= 11434
CHAT_PROMPT ?= Hello!
ANTHROPIC_BASE_URL ?= http://localhost:$(OLLAMA_PORT)
ANTHROPIC_API_KEY ?= ollama

.PHONY: default help create ensure-created run stop remove test claude-code

default: run

help:
	@printf '%s\n' \
		'default  Create $(MODEL) if needed, then run it' \
		'create  Build the local model from $(MODELFILE)' \
		'pull    Pull the base model $(BASE_MODEL)' \
		'run     Run the local model $(MODEL), creating it if needed' \
		'stop    Stop the local model $(MODEL)' \
		'remove  Remove the local model $(MODEL)' \
		'test    Send a test chat request to http://$(OLLAMA_HOST):$(OLLAMA_PORT)/api/chat' \
		'claude-code  Print the Claude Code command for $(MODEL)'

create:
	ollama create "$(MODEL)" -f "$(MODELFILE)"

ensure-created:
	@ollama show "$(MODEL)" >/dev/null 2>&1 || ollama create "$(MODEL)" -f "$(MODELFILE)"

pull:
	ollama pull "$(BASE_MODEL)"

run: ensure-created
	ollama run "$(MODEL)"

stop:
	ollama stop "$(MODEL)"

remove:
	ollama rm "$(MODEL)"

test:
	curl "http://$(OLLAMA_HOST):$(OLLAMA_PORT)/api/chat" -d '{"model":"$(MODEL)","messages":[{"role":"user","content":"$(CHAT_PROMPT)"}]}'

claude-code:
	$(info env -u CLAUDE_CODE_USE_BEDROCK -u ANTHROPIC_AUTH_TOKEN ANTHROPIC_BASE_URL="$(ANTHROPIC_BASE_URL)" ANTHROPIC_API_KEY="$(ANTHROPIC_API_KEY)" claude --model "$(MODEL)")
	@:
