#!/usr/bin/env bash
# Requires:
# - alsa-utils -> amixer
# - pulseaudio -> pactl

# Ensure Auto-Mute is off
amixer -c 0 sset 'Auto-Mute Mode' Disabled --quiet

# GET default sink id
DEFAULT_S_ID=$(pactl info | grep 'Default Sink' | awk '{ print $3 }')
# GET running sink id
S_ID=$(pactl list sinks short | awk '{ if ($7=="RUNNING") print $2 }')
S_ID=$(if [ -z ${S_ID-set} ]; then echo $DEFAULT_S_ID; else echo $S_ID; fi)

# GET Available Ports & Active Port
S_NO=$(pactl list sinks short | awk -v src=$S_ID '{ if ($2==src) print $1 }')
SINK=$(pactl list sinks | awk "/^Sink #$S_NO/,/^\s*\$/")
PORTS=$(echo $SINK | grep -o -P '(?<=Ports:)(.*)(?=Active Port:)')
A_PORT=$(echo $SINK | grep -o -P '(?<=Active Port:)(.*)(?=Formats:)' | xargs)

# GET an array of port options
readarray -t PORTS <<<$(echo $PORTS | grep -o -P '\[Out\]( |\w)+')

# GET an index of current port selection
for IDX in "${!PORTS[@]}"; do
   [[ "${PORTS[$i]}" = "${A_PORT}" ]] && break
done

# Increment index
IDX=$((IDX + 1))

PORTS_LEN=$(echo ${#PORTS[@]})
IDX=$(if ((IDX < PORTS_LEN)); then echo $IDX; else echo 0; fi)

pactl set-sink-port "$S_ID" "${PORTS[IDX]}";
