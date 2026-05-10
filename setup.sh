#!/bin/bash
# LunaSHELL v1.0 Stable - Installation Script
# -------------------------------------------

LUNA_DIR="${LUNA_HOME:-$HOME/.luna}"
LUNA_BIN="$LUNA_DIR/bin"
LUNA_ORBITS="$LUNA_DIR/orbits"
LUNA_LOGS="$LUNA_DIR/logs"
LUNA_CACHE="$LUNA_DIR/cache"

echo "Installing LunaSHELL v1.0... 🌛"

# Create directory structure
mkdir -p "$LUNA_BIN" "$LUNA_ORBITS" "$LUNA_LOGS" "$LUNA_CACHE"

# Install core scripts
cp src/luna_engine.sh "$LUNA_BIN/luna"
cp src/luna_predict.sh "$LUNA_BIN/luna-echo"
cp src/luna_tui.sh "$LUNA_BIN/luna-tide"

chmod +x "$LUNA_BIN"/*

# Shell Integration
SHELL_RC=""
[ -f "$HOME/.bashrc" ] && SHELL_RC="$HOME/.bashrc"
[ -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.zshrc"

if [ -n "$SHELL_RC" ]; then
    if ! grep -q "LUNA_HOME" "$SHELL_RC"; then
        echo "" >> "$SHELL_RC"
        echo "# LunaSHELL Integration" >> "$SHELL_RC"
        echo "export LUNA_HOME=\"$LUNA_DIR\"" >> "$SHELL_RC"
        echo "export PATH=\"\$PATH:\$LUNA_HOME/bin\"" >> "$SHELL_RC"
        echo "alias luna-train='luna-echo --train'" >> "$SHELL_RC"
    fi
fi

echo "LunaSHELL v1.0 installed successfully. 🌛"
echo "Restart your shell or run: source $SHELL_RC"

