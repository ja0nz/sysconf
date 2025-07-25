#!/usr/bin/env bash
# random_wallpaper.sh
# Randomly sets a wallpaper from your Syncthing wallpapers directory using swww.

# Exit immediately if a command exits with a non-zero status
set -e

# Set the directory containing your wallpapers
WALLPAPERS_DIR="$XDG_PICTURES_DIR/Wallpapers"

# Pick a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)

# Check if swww daemon is running; if not, start it
if ! pgrep -x swww-daemon > /dev/null; then
    echo "Starting swww-daemon..."
    swww-daemon &
    # Give the daemon a moment to start
    sleep 0.5
fi

# Set the randomly selected wallpaper using swww
swww img "$WALLPAPER"
