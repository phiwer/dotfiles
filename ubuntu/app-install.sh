#!/bin/bash

# Update repositories and update

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

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

# Npm
# Nodejs
