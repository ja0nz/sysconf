#!/usr/bin/env bash
# Requires:
# - alsa-utils -> amixer
# - pulseaudio -> pactl

# Ensure Auto-Mute is off
amixer -c 0 sset 'Auto-Mute Mode' Disabled --quiet

# Get default sink id
SINK_ID=$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')

# Some port identifiers
# Hint: 
# - pactl info -> get the default sink
# - pactl list -> get Port identifier
PORT_HEADPHONES="Headphones"
PORT_SPEAKER="Speaker"

if $(pactl list sinks | grep "Active Port" | grep -q $PORT_SPEAKER); then
	pactl set-sink-port $SINK_ID "[Out] $PORT_HEADPHONES"
else
	pactl set-sink-port $SINK_ID "[Out] $PORT_SPEAKER"
fi
