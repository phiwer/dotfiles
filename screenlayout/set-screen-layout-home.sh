#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ROOT_DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

$SCRIPT_DIR/virtual-dell.sh

feh --bg-scale $ROOT_DOTFILES_DIR/media/minimalism_sky_clouds_sun_mountains_lake_landscape_95458_1920x1080.jpg
