#!/bin/bash
# LunaSHELL TUI Dashboard - Midnight Edition v1.0
# -----------------------------------------------
# Advanced ANSI-based system monitor and control plane

LUNA_HOME="${LUNA_HOME:-$HOME/.luna}"
LUNA_ORBITS="$LUNA_HOME/orbits"

# ANSI Colors - Midnight Palette
BG="\e[48;2;0;5;16m"
FG="\e[38;2;192;192;192m"
ACCENT="\e[38;2;255;191;0m"
HIGHLIGHT="\e[38;2;0;255;255m"
ERROR="\e[31m"
RESET="\e[0m"

# Terminal dimensions
COLS=$(tput cols)
LINES=$(tput lines)

draw_box() {
    local y=$1 x=$2 h=$3 w=$4 title=$5
    tput cup $y $x
    echo -ne "${ACCENT}┌"
    for ((i=0; i<w-2; i++)); do echo -ne "─"; done
    echo -ne "┐${RESET}"
    
    tput cup $((y+1)) $((x + (w - ${#title}) / 2))
    echo -ne "${FG}${title}${RESET}"

    for ((i=1; i<h-1; i++)); do
        tput cup $((y+i)) $x
        echo -ne "${ACCENT}│${RESET}"
        tput cup $((y+i)) $((x+w-1))
        echo -ne "${ACCENT}│${RESET}"
    done

    tput cup $((y+h-1)) $x
    echo -ne "${ACCENT}└"
    for ((i=0; i<w-2; i++)); do echo -ne "─"; done
    echo -ne "┘${RESET}"
}

render_stats() {
    local cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    local mem=$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')
    local uptime_str=$(uptime -p | sed 's/up //')

    tput cup 3 5
    echo -ne "${HIGHLIGHT}CPU Usage: ${RESET}$cpu   "
    tput cup 4 5
    echo -ne "${HIGHLIGHT}Memory:    ${RESET}$mem   "
    tput cup 5 5
    echo -ne "${HIGHLIGHT}Uptime:    ${RESET}$uptime_str   "
}

render_orbits() {
    local y=8
    tput cup $y 5
    echo -ne "${HIGHLIGHT}ACTIVE ORBITS:${RESET}"
    y=$((y+1))
    
    if [ -d "$LUNA_ORBITS" ] && [ "$(ls -A "$LUNA_ORBITS")" ]; then
        for pidfile in "$LUNA_ORBITS"/*.pid; do
            local name=$(basename "$pidfile" .pid)
            local pid=$(cat "$pidfile")
            tput cup $y 5
            if kill -0 "$pid" 2>/dev/null; then
                echo -ne " 🌛 ${FG}$name ${RESET}(PID: $pid)    "
            else
                echo -ne " 🌑 ${ERROR}$name ${RESET}(DEAD)        "
            fi
            y=$((y+1))
            [ $y -gt $((LINES-5)) ] && break
        done
    else
        tput cup $y 5
        echo -ne " ${FG}No active orbits.${RESET}"
    fi
}

render_footer() {
    tput cup $((LINES-2)) 2
    echo -ne "${ACCENT}[Q] Quit  [R] Refresh  [S] Start Orbit  [K] Kill Orbit${RESET}"
}

main_tui() {
    clear
    tput civis # Hide cursor
    trap "tput cnorm; clear; exit" INT TERM EXIT

    while true; do
        draw_box 0 0 $LINES $COLS "LunaSHELL v1.0 - Night Watch"
        render_stats
        render_orbits
        render_footer
        
        read -t 2 -n 1 key
        case "$key" in
            q|Q) break ;;
            r|R) clear ;;
            s|S) 
                tput cup $((LINES-3)) 5
                echo -ne "${HIGHLIGHT}Enter orbit name: ${RESET}"
                tput cnorm; read orbit_name; tput civis
                # Logic to start orbit would go here or call luna_engine
                ;;
            k|K)
                tput cup $((LINES-3)) 5
                echo -ne "${HIGHLIGHT}Enter orbit name to kill: ${RESET}"
                tput cnorm; read orbit_name; tput civis
                [ -f "$LUNA_ORBITS/$orbit_name.pid" ] && kill $(cat "$LUNA_ORBITS/$orbit_name.pid") && rm "$LUNA_ORBITS/$orbit_name.pid"
                ;;
        esac
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_tui
fi
EOF
# Updated Sun May 10 03:53:00 CEST 2026
