# Login to Azure with an admin account
echo "    ➡️ Logging in to Azure CLI..."
az login

echo "    ✅ Azure CLI login with admin account successful!"

# Check if Azure credentials file exists, otherwise create a new Service Principal
if [ ! -f "$AZURE_SP_FILE" ]; then
    # Create the Service Principal with Contributor role and save JSON credentials
    echo "    ➡️ Creating Azure Service Principal $AZURE_SP_NAME..."
    az ad sp create-for-rbac \
        --name "$AZURE_SP_NAME" \
        --role Contributor \
        --scopes /subscriptions/"$AZURE_SUBSCRIPTION_ID" \
        --sdk-auth > "$AZURE_SP_FILE"

    echo "    ✅ Service Principal created and credentials saved to $AZURE_SP_FILE!"
else
    echo "    ℹ️ Credentials already exist at $AZURE_SP_FILE!"
fi
