# Login using the Service Principal
echo "    ➡️ Logging in to Azure CLI using Service Principal from $AZURE_SP_FILE..."

# Extract credentials from the JSON file
AZURE_SP_TENANT_ID=$(jq -r '.tenantId' "$AZURE_SP_FILE")
AZURE_SP_CLIENT_ID=$(jq -r '.clientId' "$AZURE_SP_FILE")
AZURE_SP_CLIENT_SECRET=$(jq -r '.clientSecret' "$AZURE_SP_FILE")

# Login to Azure using the Service Principal
az login --service-principal \
    --tenant "$AZURE_SP_TENANT_ID" \
    --username "$AZURE_SP_CLIENT_ID" \
    --password "$AZURE_SP_CLIENT_SECRET"

echo "    ✅ Azure CLI login with Service Principal successful!"
