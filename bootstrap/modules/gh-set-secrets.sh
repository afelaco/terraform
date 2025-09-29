# -----------------------------
# Authenticate GitHub CLI using token
# -----------------------------
echo "$GH_TOKEN" | gh auth login --with-token

# -----------------------------
# Set the Azure Service Principal credentials as a GitHub Actions secret
# -----------------------------
echo "  ➡️ Uploading Azure Service Principal credentials to GitHub Actions as '$GH_SP_CREDS_SECRET'..."
gh secret set "$GH_SP_CREDS_SECRET" \
    --repo "$GH_REPO" \
    --body "$(cat "$AZ_SP_CREDS_FILE")"

echo "  ✅ Secret '$GH_SP_CREDS_SECRET' set in GitHub Actions!"

# -----------------------------
# Set the terraform.tfvars.json content as a GitHub Actions secret
# -----------------------------
TFVARS_JSON=$(cat terraform.tfvars.json)

# Create or update GitHub Actions secret
gh secret set "$GH_EXT_SECRET" \
  --repo "$GH_REPO" \
  --body "$TFVARS_JSON"

echo "  ✅ Secret '$GH_EXT_SECRET' set in GitHub Actions!"