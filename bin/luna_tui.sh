#!/bin/bash
# LunaSHELL TUI Dashboard - Midnight Edition
# ------------------------------------------
# Advanced ANSI-based system monitor and control plane

# ANSI Colors - Midnight Palette
BG="\e[48;2;0;5;16m"
FG="\e[38;2;192;192;192m"
ACCENT="\e[38;2;255;191;0m"
RESET="\e[0m"

draw_border() {
    echo -e "${ACCENT}╔══════════════════════════════════════════════╗${RESET}"
}

draw_header() {
    echo -e "${BG}${FG} LunaSHELL v0.1 Beta - Night Watch Mode ${RESET}"
}

render_stats() {
    local cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    local mem=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
    
    echo -e "${ACCENT}System Load:${RESET} $cpu"
    echo -e "${ACCENT}Memory Use :${RESET} $mem"
}

render_orbits() {
    echo -e "${ACCENT}Active Orbits:${RESET}"
    if [ -d "$HOME/.luna/orbits" ]; then
        ls "$HOME/.luna/orbits" | sed 's/\.pid//' | while read -r orbit; do
            echo -e " 🌛 ${FG}$orbit${RESET}"
        done
    else
        echo -e " ${FG}No active orbits.${RESET}"
    fi
}

main_tui() {
    clear
    while true; do
        tput cup 0 0
        draw_border
        draw_header
        render_stats
        echo ""
        render_orbits
        draw_border
        sleep 2
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_tui
fi
EOF
# Updated Sun May 10 03:53:00 CEST 2026
