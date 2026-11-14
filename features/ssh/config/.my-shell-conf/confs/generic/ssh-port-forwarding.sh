# SSH Port Forwarding Functions
#
# Ideal for doing web development with localhost secure-context privileges against a remote box.
#
# fip: Forward one or more ports from a remote host to localhost via SSH.
# dip: Disconnect one or more forwarded ports.
# lip: List all active SSH port forwards.
# Say you start a dev server on port 3000 on a machine accessible as nyc-dev, then you can run fip nyc-dev 3000 to forward that port, so localhost:3000 actually reaches nyc-dev:3000, but without the need for SSL certificates to establish the secure context needed for testing web sockets or the like.

fip() {
  (( $# < 2 )) && echo "Usage: fip <host> <port1> [port2] ..." && return 1
  local host="$1"
  shift
  for port in "$@"; do
    ssh -f -N -L "${port}:localhost:${port}" "$host" && echo "Forwarding localhost:$port -> $host:$port"
  done
}

dip() {
  (( $# == 0 )) && echo "Usage: dip <port1> [port2] ..." && return 1
  for port in "$@"; do
    pkill -f "ssh.*-L ${port}:localhost:${port}" && echo "Stopped forwarding port $port" || echo "No forwarding on port $port"
  done
}

lip() {
  pgrep -af "ssh.*-L [0-9]+:localhost:[0-9]+" || echo "No active forwards"
}
