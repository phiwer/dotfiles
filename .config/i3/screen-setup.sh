#!/bin/sh

if [ `hostname` = "desktop" ]; then
    xrandr --output DP-0 --off --output DVI-D-0 --off --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal
elif [ `hostname` = "deathstar" ]; then
    xrandr --output DP-0 --off --output DVI-D-0 --off --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal
fi
