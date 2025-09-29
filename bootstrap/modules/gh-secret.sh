# Check file exists
if [ ! -f "$AZURE_SP_FILE" ]; then
    echo "❌ Azure credentials file not found at $AZURE_SP_FILE"
    exit 1
fi

# Login to GitHub CLI
echo "➡️ Logging in to GitHub CLI..."
gh auth login

# Create or update secret
echo "➡️ Uploading Azure SP credentials to GitHub Actions as '$GITHUB_SECRET_NAME'..."
gh secret set "$GITHUB_SECRET_NAME" \
    --repo "$GITHUB_REPO" \
    --body "$(cat "$AZURE_SP_FILE")"

echo "✅ Secret '$GITHUB_SECRET_NAME' set in GitHub Actions!"
