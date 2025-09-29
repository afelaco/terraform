#!/usr/bin/env bash
set -euo pipefail

# Load config
source "config.sh"

# Sync system environment with Brewfile
echo "➡️ Syncing system environment with Brewfile..."
brew bundle --file=Brewfile

# Declare and run bootstrap modules
modules=(
    "modules/git-config.sh"
    "modules/az-bootstrap.sh"
    "modules/gh-secret.sh"
    "modules/tf-backend.sh"
)

# Run each module
echo "➡️ Running bootstrap modules..."
for module in "${modules[@]}"; do
    echo "  ➡️ Running $(basename "$module")..."
    source "$module"
done

echo "✅ Bootstrap complete!"