source "${MAEW_AGENTS}/software-architect/.env"
mkdir -p ${MAEW_AGENT_HOME}
mkdir -p ${MAEW_AGENT_WORKFLOWS}
mkdir -p ${MAEW_AGENT_KNOWLEDGE}
mkdir -p ${MAEW_AGENT_SPACE}

TMUX_SESSION_DIRECTORY="${MAEW_AGENT_HOME}"

tmux_session_create() {
  SESSION_NAME=$1
  SESSION_DIRECTORY=$2

  # First window: MAEW_AGENT_HOME and MAEW_AGENT_KNOWLEDGE
  tmux new-session -d -s "${SESSION_NAME}" -n MAEW_AGENT_HOME -c "${SESSION_DIRECTORY}"
  tmux send-keys -t "${SESSION_NAME}:MAEW_AGENT_HOME" "# MAEW_AGENT_HOME" C-m
  tmux split-window -v -t "${SESSION_NAME}:MAEW_AGENT_HOME" -c "${MAEW_AGENT_KNOWLEDGE}"
  tmux send-keys -t "${SESSION_NAME}:MAEW_AGENT_HOME" "# MAEW_AGENT_KNOWLEDGE" C-m
  tmux select-pane -t "${SESSION_NAME}:MAEW_AGENT_HOME.0"

  # Second window: MAEW_AGENT_SPACE
  tmux new-window -t "${SESSION_NAME}" -n MAEW_AGENT_SPACE -c "${MAEW_AGENT_SPACE}"
  tmux send-keys -t "${SESSION_NAME}:MAEW_AGENT_SPACE" "# MAEW_AGENT_SPACE" C-m

  # Third window: DEFAULT_AGENT_INSTANCE
  tmux new-window -t "${SESSION_NAME}" -n DEFAULT_AGENT_INSTANCE -c "${SESSION_DIRECTORY}"
  tmux send-keys -t "${SESSION_NAME}:DEFAULT_AGENT_INSTANCE" "# DEFAULT_AGENT_INSTANCE" C-m

  # Select the default window to start with
  tmux select-window -t "${SESSION_NAME}:DEFAULT_AGENT_INSTANCE"
}
