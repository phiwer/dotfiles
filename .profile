#!/usr/bin/env bash
#
# Defines runtime environment
#

alias dots='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

export APPS="$HOME/apps"

export WALLPAPERS="$HOME/.wallpapers"

export SOURCES="$HOME/sources"

export EXTERNAL="$SOURCES/external"

export TERMINAL="rxvt-unicode"

export PATH=$PATH:$APPS/android-studio/bin
