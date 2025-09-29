#!/usr/bin/env bash
set -euo pipefail

# Check if Azure credentials file exists, otherwise create a new Service Principal
if [ ! -f "$AZURE_SP_FILE" ]; then
    # Login to Azure with an admin account to create the Service Principal
    echo "    ➡️ Logging in to Azure CLI..."
    az login

    # Create the Service Principal with Contributor role and save JSON credentials
    echo "    ➡️ Creating Azure Service Principal $AZURE_SP_NAME..."
    az ad sp create-for-rbac \
        --name "$AZURE_SP_NAME" \
        --role Contributor \
        --scopes /subscriptions/"$AZURE_SUBSCRIPTION_ID" \
        --sdk-auth > "$AZURE_SP_FILE"

    echo "    ✅ Service Principal created and saved to $AZURE_SP_FILE!"
else
    echo "    ℹ️ Service Principal $AZURE_SP_NAME already exists at $AZURE_SP_FILE"
fi

# Login using the Service Principal
echo "    ➡️ Logging in to Azure CLI using Service Principal from $AZURE_SP_FILE..."

# Extract values using jq
AZURE_SP_TENANT_ID=$(jq -r '.tenantId' "$AZURE_SP_FILE")
AZURE_SP_CLIENT_ID=$(jq -r '.clientId' "$AZURE_SP_FILE")
AZURE_SP_CLIENT_SECRET=$(jq -r '.clientSecret' "$AZURE_SP_FILE")

# Login
az login --service-principal \
    --tenant "$AZURE_SP_TENANT_ID" \
    --username "$AZURE_SP_CLIENT_ID" \
    --password "$AZURE_SP_CLIENT_SECRET"

echo "    ✅ Azure CLI login successful!"
