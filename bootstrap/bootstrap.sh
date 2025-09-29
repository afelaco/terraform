##!/usr/bin/env bash
#set -euo pipefail
#
## Load configuration
source ".config.sh"
#
## -----------------------------
## Sync system environment with Brewfile
## -----------------------------
#echo "➡️ Syncing system environment with Brewfile..."
#brew bundle --file=Brewfile
#
## -----------------------------
## Git bootstrap: set repo-level Git identity
## -----------------------------
#echo "➡️ Running Git bootstrap..."
#CURRENT_NAME=$(git config --get user.name)
#CURRENT_EMAIL=$(git config --get user.email)
#
#if [ "$CURRENT_NAME" != "$GIT_NAME" ] || [ "$CURRENT_EMAIL" != "$GIT_EMAIL" ]; then
#    source "modules/git-set-config.sh"
#    echo "✅ Git bootstrap complete!"
#else
#    echo "⚠️ Git identity already set."
#fi
#
## -----------------------------
## Azure bootstrap: create Service Principal if not exists
## -----------------------------
#echo "➡️ Running Azure bootstrap..."
#if [ ! -f "$AZ_SP_CREDS_FILE" ]; then
    source "modules/az-create-sp.sh"
    echo "✅ Azure bootstrap complete!"
#else
#    echo "⚠️ Credentials already exist at $AZ_SP_CREDS_FILE!"
#fi
#
## -----------------------------
## GitHub bootstrap: set GitHub Actions secrets
## -----------------------------
#echo "➡️ Running GitHub bootstrap..."
#source "modules/gh-set-secrets.sh"
#echo "✅ GitHub bootstrap complete!"
#
## -----------------------------
## Terraform bootstrap: create backend if not exists
## -----------------------------
#echo "➡️ Running Terraform bootstrap..."
#if [ ! -f "$TF_BE_CONFIG_FILE" ]; then
#    source "modules/tf-create-backend.sh"
#    echo "✅ Terraform bootstrap complete!"
#else
#    echo "⚠️ Terraform backend configuration already exists at $TF_BE_CONFIG_FILE!"
#fi
#
## -----------------------------
## Bootstrap complete
## -----------------------------
#echo "✅ Bootstrap complete!"
