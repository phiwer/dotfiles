#!/usr/bin/env bash
#
# Defines runtime environment
#

export VISUAL=emacs

export EDITOR="$VISUAL"


export XDG_DATA_HOME="$HOME/.local/share"

export XDG_CONFIG_HOME="$HOME/.config"


export APPS="$HOME/apps"

export WALLPAPERS="$HOME/.wallpapers"


export SOURCES="$HOME/sources"

export EXTERNAL="$SOURCES/external"

export COCOS2DX_HOME="$EXTERNAL/cocos2d-x"


export TERMINAL="rxvt-unicode"


export PATH=$PATH:$APPS/android-studio/bin:$APPS/pycharm/bin:$APPS/clion/bin
