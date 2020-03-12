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

export NDK_ROOT="$HOME/Android/Sdk/ndk-bundle/"

export ANDROID_SDK_ROOT="$HOME/Android/Sdk/"


export TERMINAL="xfce4-terminal"


export PATH=$PATH:~/apps/android-studio/bin
export PATH=$PATH:~/apps/pycharm/bin
export PATH=$PATH:~/apps/intellij/bin
export PATH=$PATH:~/apps/clion/bin
export PATH=$PATH:~/apps/rider/bin
export PATH=$PATH:~/bin

export USE_CCACHE=1
export NDK_CCACHE=/usr/bin/ccache

