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
    --sdk-auth > "$AZ_SP_CREDS_FILE"

echo "  ✅  Service Principal created and credentials saved to '$AZ_SP_CREDS_FILE'!"

# -----------------------------
# Update terraform.tfvars.json with the Service Principal Object ID
# -----------------------------
echo "  ➡️  Fetching Service Principal Object ID..."
AZ_SP_OBJECT_ID=$(az ad sp list --display-name "$AZ_SP_NAME" --query "[].id" -o tsv)

echo "  ➡️  Updating terraform.tfvars.json with SP Object ID..."
jq --arg spid "$AZ_SP_OBJECT_ID" '.azure_sp_object_id = $spid' terraform.tfvars.json \
    > terraform.tfvars.tmp.json && mv terraform.tfvars.tmp.json terraform.tfvars.json

echo "  ✅  terraform.tfvars.json updated with Azure SP Object ID!"
