# Custom functions

# Follow curl redirection
follow() {
    curl -Lvs "$1" 2>&1 | grep -i 'Location: '
}

# Start a Cloudflare Tunnel to localhost
start_localhost_tunnel() {
  TUNNEL_NAME="localhost"
  DEFAULT_PORT="8080"

  # 1. Check if cloudflared is installed
  if ! command -v cloudflared &> /dev/null; then
    echo "[!] Please install cloudflared first: brew install cloudflared"
    return 1
  fi

  # 2. Check if the tunnel exists
  if ! cloudflared tunnel list 2>/dev/null | grep -q "$TUNNEL_NAME"; then
    echo "[!] Tunnel '$TUNNEL_NAME' not found."
    echo "[!] Please initialize cloudflared and make sure ~/.cloudflared/${TUNNEL_NAME}.json exists."
    return 1
  fi

  # 3. Ask for port
  read -p "Enter local port to connect to (default is $DEFAULT_PORT): " PORT
  PORT=${PORT:-$DEFAULT_PORT}

  # 4. Start the tunnel
  echo "[+] Starting Cloudflare Tunnel '$TUNNEL_NAME' to connect localhost:$PORT ..."
  cloudflared tunnel run --url http://localhost:$PORT $TUNNEL_NAME
}
