#!/bin/sh

if [ `hostname` = "desktop" ]; then
    xrandr --output DP-0 --off --output DVI-D-0 --off --output DP-1 --off --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal
    nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
elif [ `hostname` = "deathstar" ]; then
    xrandr --output VGA-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP-6 --off
fi
