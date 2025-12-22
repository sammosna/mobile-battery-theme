#!/bin/bash
# Steam Deck Setup Script for Mobile Battery Theme
# Run this on your Mac to deploy the theme to your Deck
#
# Usage: ./deck-setup.sh <deck-ip>
# Example: ./deck-setup.sh 192.168.1.100

set -e

DECK_IP="${1:-YOUR_DECK_IP}"
THEME_DIR="$(dirname "$0")/.."

if [ "$DECK_IP" = "YOUR_DECK_IP" ]; then
    echo "Usage: $0 <deck-ip>"
    echo "Example: $0 192.168.1.100"
    exit 1
fi

echo "=== Steam Deck Theme Deployment ==="
echo "Target: deck@$DECK_IP"
echo ""

# Check if scrot is installed on Deck
echo "[1/4] Checking if scrot is installed on Deck..."
if ! ssh deck@$DECK_IP "which scrot" > /dev/null 2>&1; then
    echo "Installing scrot for screenshots..."
    ssh deck@$DECK_IP "sudo pacman -S --noconfirm scrot"
else
    echo "scrot already installed"
fi

# Create themes directory if needed
echo "[2/4] Ensuring themes directory exists..."
ssh deck@$DECK_IP "mkdir -p /home/deck/homebrew/themes"

# Deploy theme
echo "[3/4] Deploying mobile-battery-theme..."
scp -r "$THEME_DIR" deck@$DECK_IP:/home/deck/homebrew/themes/mobile-battery-theme

# Verify deployment
echo "[4/4] Verifying deployment..."
ssh deck@$DECK_IP "ls -la /home/deck/homebrew/themes/mobile-battery-theme/"

echo ""
echo "=== Deployment Complete ==="
echo ""
echo "Next steps:"
echo "1. On Steam Deck, open Quick Access Menu (... button)"
echo "2. Go to Decky > CSS Loader"
echo "3. Press 'Refresh' at bottom"
echo "4. Enable 'Mobile Battery Theme'"
echo ""
echo "To take screenshots:"
echo "  ./deck-screenshot.sh $DECK_IP preview-name"
