#!/bin/bash

# Update repositories and update

# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# I3 Repo
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb /tmp/keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f

sudo dpkg -i /tmp/keyring.deb

echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list

# Chrome repo
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa

sudo add-apt-repository ppa:aguignard/ppa

sudo apt update

sudo apt upgrade

# Hexchat
sudo apt -qq install -y hexchat

# Chrome
sudo apt -qq install -y google-chrome-stable

# I3
sudo apt -qq install -y i3

# Emacs
sudo apt -qq install -y emacs

# ZShell
sudo apt -qq install -y zsh

# Spotify
sudo apt -qq install -y spotify-client

# Xfce4 Terminal
sudo apt -qq install -y xfce4-terminal

# Feh
sudo apt -qq install -y feh

# Midnight Commander
sudo apt -qq install -y mc

# Irssi
sudo apt -qq install -y irssi

# Screen
sudo apt -qq install -y screen

# Rofi
sudo apt -qq install -y rofi

# Thunderbird
sudo apt -qq install -y thunderbird

# Arandr GUI for xrandr
sudo apt -qq install -y arandr

# Dev
sudo apt -qq install -y dh-autoreconf
sudo apt -qq install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev

# Python
sudo apt -qq install -y python-pip python-dev build-essential
sudo apt -qq install -y python3-pip
sudo pip install --upgrade pip
sudo pip install --upgrade pip3
sudo pip install --upgrade virtualenv

# Numpy & Scipy
sudo pip install numpy scipy

# Scikit learn
sudo pip install -U scikit-learn

# Pywal
sudo pip3 install pywal

# Java
sudo apt -qq install -y openjdk-8-jdk

# Curl
sudo apt -qq install -y curl

# Pidgin
sudo apt -qq install -y pidgin pidgin-sipe

# I2C Tools
sudo apt -qq install -y i2c-tools

# Silver Searcher
sudo apt -qq install -y silversearcher-ag

# Cpu Frequtils
sudo apt -qq install -y cpufrequtils

# Npm
sudo apt -qq install -y nodejs

# Global
sudo apt -qq install -y global

# CCache
sudo apt -qq install -y ccache

# KVM
sudo apt -qq install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

# CMake
sudo apt -qq install -y cmake

# Ant
sudo apt -qq install -y ant

# Gimp
sudo apt -qq install -y gimp
=======
# Git Review
sudo apt -qq install -y git-review

# cppcheck
sudo apt -qq install -y cppcheck

# meld
sudo apt -qq install -y meld

# Docker
sudo apt -qq remove -y docker docker-engine docker.io

sudo apt -qq install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key -y add -

sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update

sudo apt-get -qq install -y docker-ce

# Remove unused packages
#sudo apt autoremove
