# -----------------------------
# Authenticate GitHub CLI using token
# -----------------------------
echo "$GH_TOKEN" | gh auth login --with-token

# -----------------------------
# Set the Azure Service Principal credentials as a GitHub Actions secret
# -----------------------------
echo "  ➡️ Uploading Azure Service Principal credentials to GitHub Actions as '$GH_SECRET'..."
gh secret set "$GH_SECRET" \
    --repo "$GH_REPO" \
    --body "$(cat "$AZ_SP_CREDENTIALS_FILE")"

echo "  ✅ Secret '$GH_SECRET' set in GitHub Actions!"
