#!/bin/bash
# LunaSHELL Echo - Advanced Predictive Engine v1.0
# -----------------------------------------------
# Sophisticated command weighting, context-switching, and Markov-chain probability engine.

LUNA_ROOT="${LUNA_HOME:-$HOME/.luna}"
CACHE_DIR="$LUNA_ROOT/cache"
MARKOV_DB="$CACHE_DIR/markov.db"
HISTORY_FILE="$HOME/.bash_history"

# --- Initialization ---
init_engine() {
    mkdir -p "$CACHE_DIR"
    [ -f "$MARKOV_DB" ] || touch "$MARKOV_DB"
}

# --- Context Detection ---
detect_phase() {
    local hour=$(date +%H)
    local load=$(uptime | awk -F'load average:' '{ print $2 }' | awk -F',' '{ print $1 }' | xargs)
    
    if [ "$hour" -ge 22 ] || [ "$hour" -lt 6 ]; then
        echo "NOCTURNAL"
    elif (( $(echo "$load > 1.5" | bc -l 2>/dev/null || echo 0) )); then
        echo "FULL_MOON"
    else
        echo "WAXING"
    fi
}

# --- Training / Learning Loop ---
# Analyzes history to build Markov chains (command sequences)
train() {
    init_engine
    echo "Training Luna Echo..."
    
    # Process history to find sequences (cmd1 -> cmd2)
    # We take the last 500 commands for relevance
    tail -n 500 "$HISTORY_FILE" | awk '
    {
        if (prev != "") {
            print prev "|" $0
        }
        prev = $0
    }' | sort | uniq -c | sort -rn > "$MARKOV_DB"
}

# --- Predictive Algorithm ---
predict() {
    local input="$1"
    local phase=$(detect_phase)
    
    # If input is empty, suggest based on last command (Markov)
    if [ -z "$input" ]; then
        local last_cmd=$(tail -n 1 "$HISTORY_FILE")
        if [ -n "$last_cmd" ]; then
            grep "|$last_cmd" "$MARKOV_DB" | head -n 3 | awk -F'|' '{print $2}'
            return
        fi
    fi

    # Phase-weighted frequency analysis
    # In NOCTURNAL phase, we might prioritize maintenance or monitoring commands
    # (This is a simplified heuristic for now)
    
    echo "--- [ Luna Echo | Phase: $phase ] ---"
    
    # 1. Check Markov chains for likely next command starting with input
    local last_cmd=$(tail -n 1 "$HISTORY_FILE")
    if [ -n "$last_cmd" ]; then
        grep " $last_cmd|$input" "$MARKOV_DB" | head -n 2 | awk -F'|' '{print $2}'
    fi
    
    # 2. Fallback to frequency analysis
    grep "^$input" "$HISTORY_FILE" | tail -n 50 | sort | uniq -c | sort -rn | head -n 3 | awk '{$1=""; print $0}' | sed 's/^ //'
}

# --- Main Entry ---
case "$1" in
    "--train")
        train
        ;;
    "--predict")
        predict "$2"
        ;;
    *)
        predict "$1"
        ;;
esac
EOF
# Updated Sun May 10 03:53:00 CEST 2026
