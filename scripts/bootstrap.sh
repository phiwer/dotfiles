#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ROOT_DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo "Starting bootstrapping"

# Apt
echo "Installing applications"
APP_INSTALL_SCRIPT="$ROOT_DOTFILES_DIR/ubuntu/app-install.sh"
bash "$APP_INSTALL_SCRIPT"

# I3
I3_SOURCE_CONFIG_FILE="$ROOT_DOTFILES_DIR/i3/config"
I3_SYMLINK_CONFIG_FILE="$HOME/.config/i3/config"
ln -fs $I3_SOURCE_CONFIG_FILE $I3_SYMLINK_CONFIG_FILE
echo "i3 config file symlinked: $I3_SYMLINK_CONFIG_FILE -> $I3_SOURCE_CONFIG_FILE"

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

ln -fs "$ROOT_DOTFILES_DIR/emacs/init.el" "$HOME/.emacs.d/init.el"

ln -fs "$ROOT_DOTFILES_DIR/xfce4/terminal/terminalrc" "$HOME/.config/xfce4/terminal/terminalrc"

echo "Bootstrapping completed"
