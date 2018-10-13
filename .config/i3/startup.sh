#!/usr/bin/env bash

function main
{
    #feh --bg-scale "$HOME/.local/share/wallpapers/1984.jpg"&
    wal -i "$HOME/.local/share/wallpapers/1984.jpg"&

    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -x polybar >/dev/null; do sleep 1; done

    # Launch polybar
    FC_DEBUG=1 polybar top -l info&

    /usr/bin/compton&
}

main "$@"
