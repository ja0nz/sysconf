#!/usr/bin/env bash
# Credits: https://gitlab.com/xPMo/dotfiles.cli/-/blob/dots/.local/lib/waybar/playerctl.sh
exec 2> "$XDG_RUNTIME_DIR/waybar-playerctl.log"
IFS=$'\n\t'

# _ is needed for updating waybar
while read -r playing playerName prefix line _; do
	# remove leaders
	playing=${playing:1} playerName=${playerName:1} prefix=${prefix:1}
	# json escaping
	line="${line//\"/\\\"}"
	tooltip="$line\n$playerName"
	case $playing in
		Paused) text="$prefix $line" ;;
		Playing) text="$prefix $line" ;;
		*) text="" ;;
	esac

	# exit if print fails
	printf '{"class":"%s","text":"%s","tooltip":"%s"}\n' \
		"$playing" "$text" "$tooltip" || break 2

done < <(
	# requires playerctl>=2.0
	# Add non-space character ":" before first three parameters to prevent 'read' from skipping over them
	playerctl --follow metadata --format \
		$':{{status}}\t:{{playerName}}\t:{{emoji(status)}}\t{{markup_escape(artist)}} - {{markup_escape(title)}}\t{{position}}' &
	echo $! > "$XDG_RUNTIME_DIR/waybar-playerctl.pid"
)

kill "$(< "$XDG_RUNTIME_DIR/waybar-playerctl.pid")"
