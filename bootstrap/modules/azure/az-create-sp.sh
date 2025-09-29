# Create the Service Principal with Contributor role and save JSON credentials
echo "    ➡️ Creating Azure Service Principal $AZURE_SP_NAME..."
az ad sp create-for-rbac \
    --name "$AZURE_SP_NAME" \
    --role Contributor \
    --scopes /subscriptions/"$AZURE_SUBSCRIPTION_ID" \
    --sdk-auth > "$AZURE_SP_FILE"

echo "    ✅ Service Principal created and credentials saved to $AZURE_SP_FILE!"