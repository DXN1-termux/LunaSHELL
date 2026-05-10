#!/bin/bash

# LunaSHELL Setup Wizard
echo "--- LunaSHELL Setup Wizard 🌛 ---"

# 1. Installation Directory
read -p "Enter installation directory [default: ~/.luna]: " LUNA_DIR
LUNA_DIR=${LUNA_DIR:-$HOME/.luna}
mkdir -p "$LUNA_DIR"

# 2. Shell Integration
echo "Do you want to add LunaSHELL to your shell profile (.bashrc/.zshrc)?"
read -p "[y/n] " ADD_SHELL_INTEGRATION

if [ "$ADD_SHELL_INTEGRATION" = "y" ]; then
    SHELL_PROFILE=""
    [ -f "$HOME/.bashrc" ] && SHELL_PROFILE="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && SHELL_PROFILE="$HOME/.zshrc"

    if [ -n "$SHELL_PROFILE" ]; then
        echo "Adding to $SHELL_PROFILE..."
        echo "export LUNA_HOME=$LUNA_DIR" >> "$SHELL_PROFILE"
        echo 'export PATH="$PATH:$LUNA_HOME/bin"' >> "$SHELL_PROFILE"
        echo "Successfully added to $SHELL_PROFILE. Please restart your shell."
    else
        echo "Could not find .bashrc or .zshrc. Manual configuration required."
    fi
fi

echo "LunaSHELL installed in $LUNA_DIR. 🌛"
