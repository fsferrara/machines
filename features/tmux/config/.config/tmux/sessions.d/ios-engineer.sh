TMUX_SESSION_DIRECTORY="$MAEW_AGENTS/ios-engineer"

tmux_session_create() {
  session_name=$1
  session_directory=$2
  agent_instance_command='claude-dangerous'

  tmux new-session -d -s "$session_name" -n agent_home -c "$session_directory"
  tmux send-keys -t "$session_name:agent_home" "nvim $session_directory" C-m

  tmux new-window -t "$session_name" -n default_agent_instance -c "$session_directory"
  tmux send-keys -t "$session_name:default_agent_instance" "$agent_instance_command" C-m

  tmux select-window -t "$session_name:default_agent_instance"
}
