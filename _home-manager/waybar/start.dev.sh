#!/usr/bin/env bash

set -euo pipefail

template_file="./config.template"
style_file="./style-base.css"
generator_script="./make_configjsonc.sh"

# Global var for Waybar PID
waybar_pid=""

restart_waybar() {
    echo "🔁 Restarting Waybar..."
    if pgrep waybar >/dev/null; then
        pkill waybar
        sleep 0.2
    fi

    # Start Waybar in background and store its PID
    waybar --log-level trace &
    waybar_pid=$!
    echo "✅ Waybar started at $(date)"
}

cleanup() {
    echo "🛑 Caught signal, exiting..."
    if [[ -n "$waybar_pid" ]]; then
        kill "$waybar_pid" &>/dev/null || true
    fi
    exit 0
}

# Register signal handlers
trap cleanup SIGINT SIGTERM

# Watch for changes and regenerate config
while true; do
    inotifywait -q -e close_write "$template_file" "$style_file"
    echo "🔧 Change detected — regenerating config..."
    bash "$generator_script"
    restart_waybar
done

