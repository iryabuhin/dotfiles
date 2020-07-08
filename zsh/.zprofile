#!/bin/zsh
#
# Runs on login. Put here stuff that doesn't change that often.

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export SUDO_ASKPASS=$HOME/.local/bin/askpass-rofi

export ALACRITTY_COLORS_DIR="$HOME/.local/share/alacritty/themes"


