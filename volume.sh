#!/usr/bin/zsh


case $BLOCK_BUTTON in
    3) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;  # right click, mute/unmute
    4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;; # scroll up, increase
    5) pactl set-sink-volume @DEFAULT_SINK@ -5% ; ;; # scroll down, decrease
esac

pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]%*\).*,\1,'
