# -----------------------------
# Login to Azure with an admin account
# -----------------------------
echo "  ➡️ Logging in to Azure CLI..."
az login
echo "  ✅ Azure CLI login successful!"

# -----------------------------
# Create the Service Principal with Contributor role and save credentials
# -----------------------------
echo "  ➡️ Creating Azure Service Principal: $AZ_SP_NAME..."
az ad sp create-for-rbac \
    --name "$AZ_SP_NAME" \
    --sdk-auth > "$AZ_SP_CREDS_FILE"

echo "  ✅ Service Principal $AZ_SP_NAME created and credentials saved to $AZ_SP_CREDS_FILE!"

# -----------------------------
# Assign roles to the Service Principal
# -----------------------------
echo "  ➡️ Assigning roles to Service Principal..."

# Extract SP appId from JSON
AZ_SP_APP_ID=$(jq -r '.clientId' < "$AZ_SP_CREDS_FILE")

# 2️⃣ Assign Contributor role for creating resources
echo "➡️ Assigning Contributor role to Service Principal $AZ_SP_NAME..."
az role assignment create \
    --assignee "$AZ_SP_APP_ID" \
    --role "Contributor" \
    --scope /subscriptions/"$AZ_SUBSCRIPTION_ID"

# 3️⃣ Assign Key Vault Contributor role for creating secrets
echo "➡️ Assigning Key Vault Contributor role to Service Principal $AZ_SP_NAME..."
az role assignment create \
    --assignee "$AZ_SP_APP_ID" \
    --role "Key Vault Contributor" \
    --scope /subscriptions/"$AZ_SUBSCRIPTION_ID"

echo "✅ Service Principal roles assigned!"
