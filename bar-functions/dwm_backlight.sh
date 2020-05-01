#!/bin/sh

# A dwm_bar module to display the current backlight brighness with xbacklight
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: brightnessctl

dwm_backlight () {
    printf "%s☀ %.0f %s\n" "$SEP1" "$(brightnessctl -m | grep -oP "...%" | grep -Eo '[0-9]{1,4}')" "$SEP2"
}

dwm_backlight
