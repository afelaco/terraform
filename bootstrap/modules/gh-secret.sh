# Check if Azure Service Principal credentials file exists
if [ ! -f "$AZ_SP_CREDENTIALS_FILE" ]; then
    echo "❌ Azure credentials file not found at $AZ_SP_CREDENTIALS_FILE"
    exit 1
fi

# Use the token variable to login
echo "$GH_TOKEN" | gh auth login --with-token

# Set the secret in GitHub Actions
echo "    ➡️ Uploading Azure SP credentials to GitHub Actions as '$GH_SECRET'..."
gh secret set "$GH_SECRET" \
    --repo "$GH_REPO" \
    --body "$(cat "$AZ_SP_CREDENTIALS_FILE")"

echo "    ✅ Secret '$GH_SECRET' set in GitHub Actions!"
