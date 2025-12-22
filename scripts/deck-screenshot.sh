#!/bin/bash
# Steam Deck Screenshot Helper for Mobile Battery Theme
# Run this on your Mac to take screenshots from your Steam Deck
#
# Prerequisites:
# 1. SSH enabled on Steam Deck (Settings > System > Enable Developer Mode)
# 2. Set a password: passwd (in Konsole on Deck)
# 3. Know your Deck's IP (Settings > Network)
#
# Usage: ./deck-screenshot.sh <deck-ip> [output-name]
# Example: ./deck-screenshot.sh 192.168.1.100 ios26-horizontal

set -e

DECK_IP="${1:-YOUR_DECK_IP}"
OUTPUT_NAME="${2:-battery-theme-preview}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_FILE="${OUTPUT_NAME}_${TIMESTAMP}.png"

if [ "$DECK_IP" = "YOUR_DECK_IP" ]; then
    echo "Usage: $0 <deck-ip> [output-name]"
    echo "Example: $0 192.168.1.100 ios26-horizontal"
    exit 1
fi

echo "Connecting to Steam Deck at $DECK_IP..."

# Take screenshot on Deck
ssh deck@$DECK_IP "DISPLAY=:0 scrot /tmp/screenshot.png"

# Copy to local machine
scp deck@$DECK_IP:/tmp/screenshot.png "./$OUTPUT_FILE"

# Clean up remote
ssh deck@$DECK_IP "rm /tmp/screenshot.png"

echo "Screenshot saved: $OUTPUT_FILE"

# Optional: Open in Preview (macOS)
if [ "$(uname)" = "Darwin" ]; then
    open "$OUTPUT_FILE"
fi
