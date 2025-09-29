# Check file exists
if [ ! -f "$AZURE_SP_FILE" ]; then
    echo "❌ Azure credentials file not found at $AZURE_SP_FILE"
    exit 1
fi

# Create or update secret
echo "➡️ Uploading Azure SP credentials to GitHub Actions as '$GH_SECRET'..."
gh secret set "$GH_SECRET" \
    --repo "$GH_REPO" \
    --body "$(cat "$AZURE_SP_FILE")"

echo "✅ Secret '$GH_SECRET' set in GitHub Actions!"
