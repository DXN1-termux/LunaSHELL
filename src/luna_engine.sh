#!/bin/bash
# LunaSHELL Core Engine v0.1-beta
# -------------------------------
# Modular daemon and process orchestrator

LUNA_HOME="$HOME/.luna"
LUNA_ORBITS="$LUNA_HOME/orbits"
LUNA_LOGS="$LUNA_HOME/logs"

# Logger
luna_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [LUNA-$1] $2" >> "$LUNA_LOGS/daemon.log"
}

# Process Controller
manage_orbit() {
    local cmd="$1"
    local name="$2"
    luna_log "INFO" "Launching orbit: $name"
    nohup $cmd > "$LUNA_LOGS/$name.log" 2>&1 &
    echo $! > "$LUNA_ORBITS/$name.pid"
}

check_orbits() {
    for pidfile in "$LUNA_ORBITS"/*.pid; do
        if [ -f "$pidfile" ]; then
            pid=$(cat "$pidfile")
            if ! kill -0 $pid 2>/dev/null; then
                luna_log "WARN" "Orbit ${pidfile##*/} died. Restarting..."
                # Logic to recover process
            fi
        fi
    done
}

# Main Engine Execution
main() {
    mkdir -p "$LUNA_ORBITS" "$LUNA_LOGS"
    luna_log "START" "LunaSHELL Engine Online"
    
    while true; do
        check_orbits
        sleep 5
    done
}

# Ensure file is executed correctly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
