#!/bin/sh

if [ `hostname` = "desktop" ]; then
    xrandr --output DP-0 --off --output DVI-D-0 --off --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal
elif [ `hostname` = "deathstar" ]; then
    xrandr --output VGA-0 --off --output DP-6 --off --output DP-5 --primary --mode 3840x2160 --pos 1920x0 --rotate normal --output DP-4 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-3 --off --output DP-2 --off --output DP-1 --off --output DP-0 --off
fi
