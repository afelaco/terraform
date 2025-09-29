# Check if Terraform config file exists, otherwise run the module
if [ ! -f "$TF_BE_CONFIG_FILE" ]; then
    # Create Resource Group
    az group create \
      -n $TF_BE_RG \
      -l $TF_BE_RG_LOCATION

    # Create Storage Account
    az storage account create \
      -g $TF_BE_RG \
      -n $TF_BE_SA \
      -l $TF_BE_RG_LOCATION \
      --sku Standard_LRS

    # Get Storage Account key
    TF_BE_SA_KEY=$(az storage account keys list \
      -g $TF_BE_RG \
      -n $TF_BE_SA --query "[0].value" -o tsv)

    # Create container
    az storage container create \
      --account-name $TF_BE_SA \
      --account-key $TF_BE_SA_KEY \
      --name $TF_BE_CONTAINER

    # Write Terraform backend configuration to file
    cat > "$TF_BE_CONFIG_FILE" <<-EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "$TF_BE_RG"
    storage_account_name = "$TF_BE_SA"
    container_name       = "$TF_BE_CONTAINER"
    key                  = "terraform.tfstate"
  }
}
EOF

    echo "    ✅ Terraform backend configuration written to $TF_BE_CONFIG_FILE!"
    echo "    ✅ Terraform bootstrap complete!"

else
    echo "    ℹ️ Terraform config file already exist at $TF_BE_CONFIG_FILE!"
fi
