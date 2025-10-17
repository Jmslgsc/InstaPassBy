#!/bin/bash
# Results helper: lists history and displays saved results

RESULTS_DIR="results"
HISTORY="$RESULTS_DIR/history.log"

if [ ! -d "$RESULTS_DIR" ]; then
    echo "No results directory found. Run Main.sh to generate results."
    exit 0
fi

echo "Available result files:"
# match YYYYMMDD-HHMMSS-<pid>-<nanoseconds>.txt (pid and ns are numeric)
ls -1 "$RESULTS_DIR" | grep -E '^[0-9]{8}-[0-9]{6}-[0-9]+-[0-9]+\.txt$' | sort -r | nl -ba | sed -n '1,50p'

echo
echo "Options:"
echo "  1) Show latest result"
echo "  2) Choose result number to display"
echo "  3) Show history log"
read -p "Choose [1-3]: " opt

case "$opt" in
    1)
    latest=$(ls -1 "$RESULTS_DIR" | grep -E '^[0-9]{8}-[0-9]{6}-[0-9]+-[0-9]+\.txt$' | sort -r | head -n1)
        if [ -n "$latest" ]; then
            echo "--- $latest ---"
            nl -ba "$RESULTS_DIR/$latest"
        else
            echo "No result files found."
        fi
        ;;
    2)
        read -p "Enter file number: " num
    file=$(ls -1 "$RESULTS_DIR" | grep -E '^[0-9]{8}-[0-9]{6}-[0-9]+-[0-9]+\.txt$' | sort -r | nl -ba | sed -n "${num}p" | awk '{$1=""; print $0}' | sed 's/^ *//')
        if [ -n "$file" ]; then
            echo "--- $file ---"
            nl -ba "$RESULTS_DIR/$file"
        else
            echo "Invalid selection or no file found."
        fi
        ;;
    3)
        if [ -f "$HISTORY" ]; then
            nl -ba "$HISTORY"
        else
            echo "No history log found."
        fi
        ;;
    *)
        echo "Cancelled."
        ;;
esac
