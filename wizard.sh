#!/bin/bash

# Enhanced LunaSHELL Setup Wizard
echo -e "\033[1;36m--- LunaSHELL Setup Wizard 🌛 ---\033[0m"

# Simple animation function
animate() {
    local str="$1"
    for (( i=0; i<${#str}; i++ )); do
        echo -n "${str:$i:1}"
        sleep 0.05
    done
    echo ""
}

animate "Initializing installation sequence..."

# 1. Installation Directory
read -p "Enter installation directory [default: ~/.luna]: " LUNA_DIR
LUNA_DIR=${LUNA_DIR:-$HOME/.luna}
mkdir -p "$LUNA_DIR"

animate "Directory prepared: $LUNA_DIR"

# 2. Shell Integration
echo -e "\033[0;33mDo you want to add LunaSHELL to your shell profile?\033[0m"
read -p "[y/n] " ADD_SHELL_INTEGRATION

if [ "$ADD_SHELL_INTEGRATION" = "y" ]; then
    SHELL_PROFILE=""
    [ -f "$HOME/.bashrc" ] && SHELL_PROFILE="$HOME/.bashrc"
    [ -f "$HOME/.zshrc" ] && SHELL_PROFILE="$HOME/.zshrc"

    if [ -n "$SHELL_PROFILE" ]; then
        animate "Configuring shell integration in $SHELL_PROFILE..."
        echo -e "\n# LunaSHELL Integration" >> "$SHELL_PROFILE"
        echo "export LUNA_HOME=$LUNA_DIR" >> "$SHELL_PROFILE"
        echo 'export PATH="$PATH:$LUNA_HOME/bin"' >> "$SHELL_PROFILE"
        animate "Configuration successful. ✨"
    else
        echo -e "\033[0;31mError: Could not find .bashrc or .zshrc.\033[0m"
    fi
fi

echo -e "\033[1;32mInstallation complete. Welcome to the Moon! 🌛\033[0m"
