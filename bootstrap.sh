#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ROOT_DOTFILES_DIR=$SCRIPT_DIR

echo "Starting bootstrapping"

# Apt
echo "Installing applications"
APP_INSTALL_SCRIPT="$ROOT_DOTFILES_DIR/ubuntu/app-install.sh"
bash "$APP_INSTALL_SCRIPT"

# Fonts
echo "Symlinking fonts"
ln -fs "$ROOT_DOTFILES_DIR/fonts" "$HOME/.fonts"

# I3
I3_SOURCE_CONFIG_FILE=""
SCREEN_LAYOUT_CONFIG_FILE=""
PS3='Please enter your i3 config choice: '
options=("Desktop Home" "Thinkpad" "Desktop Work" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Desktop Home")
            echo "You selected home configuration"
	        I3_SOURCE_CONFIG_FILE="$ROOT_DOTFILES_DIR/i3/config-desktop"
            SCREEN_LAYOUT_CONFIG_FILE="$ROOT_DOTFILES_DIR/screenlayout/set-screen-layout-home.sh"
	    break
            ;;
        "Thinkpad")
            echo "You selected thinkpad configuration"
	        I3_SOURCE_CONFIG_FILE="$ROOT_DOTFILES_DIR/i3/config-thinkpad"
            SCREEN_LAYOUT_CONFIG_FILE="$ROOT_DOTFILES_DIR/screenlayout/set-screen-layout-volvo.sh"
	    break
            ;;
        "Desktop Work")
            echo "You selected work configuration"
	        I3_SOURCE_CONFIG_FILE="$ROOT_DOTFILES_DIR/i3/config-work"
            SCREEN_LAYOUT_CONFIG_FILE="$ROOT_DOTFILES_DIR/screenlayout/set-screen-layout-volvo.sh"
	    break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

mkdir -p "$HOME/.config/i3"

I3_SYMLINK_CONFIG_FILE="$HOME/.config/i3/config"
ln -fs $I3_SOURCE_CONFIG_FILE $I3_SYMLINK_CONFIG_FILE
echo "i3 config file symlinked: $I3_SYMLINK_CONFIG_FILE -> $I3_SOURCE_CONFIG_FILE"

SCREEN_LAYOUT_SYMLINK_CONFIG_FILE="$HOME/dotfiles/screenlayout/set-screen-layout.sh"
ln -fs $SCREEN_LAYOUT_CONFIG_FILE $SCREEN_LAYOUT_SYMLINK_CONFIG_FILE


# ZShell
ZSH_PATH=`which zsh`
echo "Changing default shell to zsh"
chsh -s "$ZSH_PATH"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
    echo "Deleted old zsh rc file"
fi
ln -fs "$ROOT_DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -fs "$ROOT_DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"

# Emacs
if [ -f ~/.emacs.d/init.el ]; then
    rm ~/.emacs.d/init.el
    echo "Deleted old emacs init.el file"
fi

mkdir -p "$HOME/.emacs.d"

ln -fs "$ROOT_DOTFILES_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"

ln -fs "$ROOT_DOTFILES_DIR/emacs/themes" "$HOME/.emacs.d/themes"

ln -fs "$ROOT_DOTFILES_DIR/emacs/custom" "$HOME/.emacs.d/custom"

# Xfce4-Terminal
mkdir -p $HOME/.config/xfce4/terminal
ln -fs "$ROOT_DOTFILES_DIR/xfce4/terminal/terminalrc" "$HOME/.config/xfce4/terminal/terminalrc"

# Xresources
ln -fs "$ROOT_DOTFILES_DIR/env/.Xresources" "$HOME/.Xresources"
xrdb ~/.Xresources

# Screen
ln -fs "$ROOT_DOTFILES_DIR/screen/.screenrc" "$HOME/.screenrc"

# Midnight Commander
mkdir -p $HOME/.config/mc
ln -fs "$ROOT_DOTFILES_DIR/mc/ini" "$HOME/.config/mc/ini"

# Profiles
ln -fs "$ROOT_DOTFILES_DIR/env/.profile" "$HOME/.profile"
ln -fs "$ROOT_DOTFILES_DIR/env/.zprofile" "$HOME/.zprofile"

# Log directory
mkdir -p "$HOME/logs/minicom"

echo "Bootstrapping completed"