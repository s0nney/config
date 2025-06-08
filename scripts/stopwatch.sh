#!/bin/bash

# Usage: ./stopwatch.sh

start_time=0
end_time=0
elapsed=0
running=false

display_help() {
    echo "Stopwatch Controls:"
    echo "  s - Start/Pause"
    echo "  r - Reset"
    echo "  q - Quit"
    echo -e "\nPress any control key to continue..."
}

format_time() {
    local seconds=$1
    printf "%02d:%02d:%02d" $((seconds/3600)) $((seconds%3600/60)) $((seconds%60))
}

clear
display_help

while true; do
    if $running; then
        current_time=$(date +%s)
        elapsed=$((current_time - start_time + paused_offset))
        clear
        echo -e "Stopwatch Running\n"
        echo "Time: $(format_time $elapsed)"
        display_help
    fi

    # Non-blocking key read (1 second timeout)
    read -rs -n1 -t1 key || continue

    case $key in
        s) # Start/Pause
            if $running; then
                running=false
                paused_offset=$elapsed
            else
                running=true
                start_time=$(date +%s)
                [ -z "$paused_offset" ] && paused_offset=0
            fi
            ;;
        r) # Reset
            running=false
            start_time=0
            end_time=0
            elapsed=0
            paused_offset=0
            clear
            echo -e "Stopwatch Reset\n"
            display_help
            ;;
        q) # Quit
            clear
            echo "Final Time: $(format_time $elapsed)"
            exit 0
            ;;
        *) # Ignore other keys
            ;;
    esac
done
