#!/bin/bash

# LunaSHELL v0.1 Beta - Setup Script
LUNA_DIR="$HOME/.luna"
THEME_DIR="$LUNA_DIR/themes"

echo "Installing LunaSHELL... 🌛"

mkdir -p "$THEME_DIR"

# Define Midnight Palette
cat <<EOF > "$THEME_DIR/midnight.luna"
# LunaSHELL Midnight Palette
BACKGROUND="#000510"
ACCENT_MOON="#C0C0C0"
ACCENT_AMBER="#FFBF00"
EOF

# Placeholder for shell integration
echo "LunaSHELL environment configured in $LUNA_DIR"
echo "LunaSHELL v0.1 Beta installed successfully. 🌛"

