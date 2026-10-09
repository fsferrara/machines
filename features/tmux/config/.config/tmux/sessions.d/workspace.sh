TMUX_SESSION_DIRECTORY="${WORKSPACE}"

tmux_session_create() {
  SESSION_NAME=$1
  SESSION_DIRECTORY=$2

  # First window: WORKSPACE and SPACES
  tmux new-session -d -s "${SESSION_NAME}" -n WORKSPACE -c "${SESSION_DIRECTORY}"
  tmux send-keys -t "${SESSION_NAME}:WORKSPACE" "# WORKSPACE" C-m
  tmux split-window -v -t "${SESSION_NAME}:WORKSPACE" -c "${SPACES}"
  tmux send-keys -t "${SESSION_NAME}:WORKSPACE" "# SPACES" C-m
  tmux select-pane -t "${SESSION_NAME}:WORKSPACE.0"

  # Select the default window to start with
  tmux select-window -t "${SESSION_NAME}:WORKSPACE"
}
