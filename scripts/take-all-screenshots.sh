#!/bin/bash
# Take screenshots of all battery theme variations
# Run this after enabling each style in CSS Loader
#
# Usage: ./take-all-screenshots.sh <deck-ip>

set -e

DECK_IP="${1:-YOUR_DECK_IP}"
SCRIPT_DIR="$(dirname "$0")"
OUTPUT_DIR="$SCRIPT_DIR/../previews"

if [ "$DECK_IP" = "YOUR_DECK_IP" ]; then
    echo "Usage: $0 <deck-ip>"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "=== Battery Theme Screenshot Session ==="
echo ""
echo "This script will help you capture screenshots of each style."
echo "You'll need to manually switch styles in CSS Loader between shots."
echo ""

STYLES=(
    "ios26-horizontal"
    "ios26-vertical"
    "android16-horizontal"
    "android16-vertical"
    "retro-ios"
    "retro-android"
)

for style in "${STYLES[@]}"; do
    echo ""
    echo "Ready to capture: $style"
    echo "1. Open CSS Loader on your Deck"
    echo "2. Select '$style' from Battery Style dropdown"
    echo "3. Press Enter here when ready..."
    read -r

    echo "Taking screenshot..."
    ssh deck@$DECK_IP "DISPLAY=:0 scrot /tmp/screenshot.png"
    scp deck@$DECK_IP:/tmp/screenshot.png "$OUTPUT_DIR/${style}.png"
    ssh deck@$DECK_IP "rm /tmp/screenshot.png"
    echo "Saved: $OUTPUT_DIR/${style}.png"
done

echo ""
echo "=== All screenshots captured! ==="
echo "Files saved in: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR"

# Create a montage if ImageMagick is available
if command -v montage &> /dev/null; then
    echo ""
    echo "Creating preview montage..."
    montage "$OUTPUT_DIR"/*.png -geometry 400x240+4+4 -tile 3x2 "$OUTPUT_DIR/preview-montage.png"
    echo "Montage saved: $OUTPUT_DIR/preview-montage.png"
fi
