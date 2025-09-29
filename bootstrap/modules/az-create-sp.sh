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
    --role Contributor \
    --scopes /subscriptions/"$AZ_SUBSCRIPTION_ID" \
    --sdk-auth > "$AZ_SP_CREDENTIALS_FILE"

echo "  ✅ Service Principal created and credentials saved to $AZ_SP_CREDENTIALS_FILE!"
