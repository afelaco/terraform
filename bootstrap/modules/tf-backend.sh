# Create Resource Group
az group create \
  -n $TERRAFORM_BACKEND_RESOURCE_GROUP_NAME \
  -l $TERRAFORM_BACKEND_RESOURCE_GROUP_LOCATION

# Create Storage Account
az storage account create \
  -g $TERRAFORM_BACKEND_RESOURCE_GROUP_NAME \
  -n $TERRAFORM_BACKEND_STORAGE_ACCOUNT_NAME \
  -l $TERRAFORM_BACKEND_RESOURCE_GROUP_LOCATION \
  --sku Standard_LRS

# Get storage key
TERRAFORM_BACKEND_STORAGE_ACCOUNT_ACCOUNT_KEY=$(az storage account keys list \
  -g $TERRAFORM_BACKEND_RESOURCE_GROUP_NAME \
  -n $TERRAFORM_BACKEND_STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Create container
az storage container create \
  --account-name $TERRAFORM_BACKEND_STORAGE_ACCOUNT_NAME \
  --account-key $TERRAFORM_BACKEND_STORAGE_ACCOUNT_ACCOUNT_KEY \
  --name $TERRAFORM_BACKEND_CONTAINER_NAME

# Write Terraform backend configuration to file
cat > "$TERRAFORM_BACKEND_FILE" <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "$TERRAFORM_BACKEND_RESOURCE_GROUP_NAME"
    storage_account_name = "$TERRAFORM_BACKEND_STORAGE_ACCOUNT_NAME"
    container_name       = "$TERRAFORM_BACKEND_CONTAINER_NAME"
    key                  = "terraform.tfstate"
  }
}
EOF

echo "    ✅ Terraform backend configuration written to $TERRAFORM_BACKEND_FILE!"
