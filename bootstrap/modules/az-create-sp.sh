# -----------------------------
# Login to Azure with an admin account
# -----------------------------
echo "  ➡️  Logging in to Azure CLI..."
az login
echo "  ✅  Azure CLI login successful!"

# -----------------------------
# Create the Service Principal with Owner role and save credentials
# -----------------------------
echo "  ➡️  Creating Azure Service Principal: $AZ_SP_NAME..."
az ad sp create-for-rbac \
    --name "$AZ_SP_NAME" \
    --role Owner \
    --scopes "/subscriptions/$AZ_SUBSCRIPTION_ID" \
    --sdk-auth >"$AZ_SP_CREDS_FILE"

echo "  ✅  Service Principal created and credentials saved to '$AZ_SP_CREDS_FILE'!"

# -----------------------------
# Update terraform.tfvars.json with the Service Principal Object ID
# -----------------------------
echo "  ➡️  Fetching Service Principal Object ID..."
AZ_SP_OBJECT_ID=$(az ad sp list --display-name "$AZ_SP_NAME" --query "[].id" -o tsv)

echo "  ➡️  Updating $TF_VARS_FILE with Service Principal Object ID..."
jq --arg spid "$AZ_SP_OBJECT_ID" '.sp_object_id = $spid' "$TF_VARS_FILE" | sponge "$TF_VARS_FILE"

echo "  ✅  $TF_VARS_FILE updated with Azure Service Principal Object ID!"
