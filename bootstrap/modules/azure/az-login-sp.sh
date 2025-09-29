# Login using the Service Principal
echo "    ➡️ Logging in to Azure CLI using Service Principal from $AZ_SP_CREDENTIALS_FILE..."

# Extract credentials from the JSON file
AZ_SP_TENANT_ID=$(jq -r '.tenantId' "$AZ_SP_CREDENTIALS_FILE")
AZ_SP_CLIENT_ID=$(jq -r '.clientId' "$AZ_SP_CREDENTIALS_FILE")
AZ_SP_CLIENT_SECRET=$(jq -r '.clientSecret' "$AZ_SP_CREDENTIALS_FILE")

# Login to Azure using the Service Principal
az login --service-principal \
    --tenant "$AZ_SP_TENANT_ID" \
    --username "$AZ_SP_CLIENT_ID" \
    --password "$AZ_SP_CLIENT_SECRET"

echo "    ✅ Azure CLI login with Service Principal successful!"
