#!/usr/bin/env bash
set -euo pipefail

# Load config
source "config.sh"

# Brewfile-based bootstrap script for macOS
echo "➡️ Syncing system environment with Brewfile..."
brew bundle --file=Brewfile

echo "➡️ Running bootstrap modules..."
for module in "modules/"*.sh; do
    echo "  ➡️ Running $(basename "$module")..."
    source "$module"
done

echo "✅ Bootstrap complete!"