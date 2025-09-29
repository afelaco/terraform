## -----------------------------
## Login to Azure with an admin account
## -----------------------------
#echo "  ➡️  Logging in to Azure CLI..."
#az login
#echo "  ✅  Azure CLI login successful!"
#
## -----------------------------
## Create the Service Principal with Owner role and save credentials
## -----------------------------
#echo "  ➡️  Creating Azure Service Principal: $AZ_SP_NAME..."
#az ad sp create-for-rbac \
#    --name "$AZ_SP_NAME" \
#    --role Owner \
#    --scopes "/subscriptions/$AZ_SUBSCRIPTION_ID" \
#    --sdk-auth >"$AZ_SP_CREDS_FILE"
#
#echo "  ✅  Service Principal created and credentials saved to '$AZ_SP_CREDS_FILE'!"
#
## -----------------------------
## Fetch and save the Service Principal Object ID to a text file
## -----------------------------
echo "  ➡️  Fetching Service Principal Object ID..."
az ad sp list --display-name "$AZ_SP_NAME" --query "[].id" -o tsv > "$AZ_SP_OBJECT_ID_FILE"

echo "  ✅  Azure Service Principal Object ID written to $AZ_SP_OBJECT_ID_FILE!"
