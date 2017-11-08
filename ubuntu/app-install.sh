#!/bin/bash

# Update repositories and update

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa

sudo apt update

sudo apt upgrade

# Emacs
sudo apt install emacs

# ZShell
sudo apt install zsh

# Spotify
sudo apt install spotify-client

# Xfce4 Terminal
sudo apt install xfce4-terminal

# Feh
sudo apt install feh

# Midnight Commander
sudo apt install mc

# Irssi
sudo apt install irssi

# Screen
sudo apt install screen

# Rofi
sudo apt install rofi

# Thunderbird
sudo apt install thunderbird

# Arandr GUI for xrandr
sudo apt install arandr

# Dev
sudo apt install dh-autoreconf
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev

# Python
sudo apt install python-pip python-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade pip3
sudo pip install --upgrade virtualenv

# Pywal
sudo pip3 install pywal

# Java
sudo apt install openjdk-8-jdk

# Npm
# Nodejs
