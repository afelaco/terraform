# terraform

This repository contains Terraform configurations to provision and manage Azure resources.

---

## Setup Service Principal & Azure Credentials for Terraform

Before Terraform can manage Azure resources, a `terraform-sp` Service Principal (SP) needs to be created with the
necessary permissions. To login to Azure CLI, use the following command:

```bash
az login
```

Follow the instructions in the terminal to select the correct subscription, or run:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

To create a Service Principal named `terraform-sp` within the current subscription, use the
following command in the Azure CLI:

```bash
SP_NAME="terraform-sp"
ROLE="Contributor"
SCOPE="/subscriptions/<SUBSCRIPTION_ID>"

az ad sp create-for-rbac \
    --name "$SP_NAME" \
    --role "$ROLE" \
    --scopes "$SCOPE" \
    --sdk-auth
```

`--sdk-auth` outputs a JSON file in the format Terraform expects it as `AZURE_CREDENTIALS` in GitHub Actions. Do not
include these credentials in the code or check the credentials into source control!

The output will look something like this:

```json
{
  "clientId": "<YOUR_CLIENT_ID>",
  "clientSecret": "<YOUR_CLIENT_SECRET>",
  "subscriptionId": "<YOUR_SUBSCRIPTION_ID>",
  "tenantId": "<YOUR_TENANT_ID>",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.azure.com/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

> The client secret will only be shown once, so make sure to copy it locally to later store it as a
`TERRAFORM-SP-CLIENT-SECRET` secret in the Azure
> Key Vault!

Copy the JSON and set it as a GitHub secret named `AZURE_CREDENTIALS`. This secret can be used in GitHub Actions
workflows
to authenticate Terraform with Azure:

```yaml
  - name: Login to Azure
    uses: azure/login@v1
    with:
      creds: ${{ secrets.AZURE_CREDENTIALS }}
```

---

## Setup & Migrate Terraform State to Remote Backend

The initial `main.tf` file is set up to run Terraform locally. This file will include the storage account and container
resources needed for the remote backend, as well as other resources you may want to create:

```tf
resource "azurerm_storage_account" "tf" {
  name                     = "${var.project_name}tf"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.tf.name
}
```

For now, the actual backend configuration is commented out in the `main.tf` file:

```tf
# # Terraform Backend Configuration
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "homeauto-rg"
#     storage_account_name = "homeautotf"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }
```

> The `resource_group_name`, `storage_account_name`, `container_name`, and `key` values cannot refrerence variables or
> data
> sources, so they are hardcoded here, and should match the values used when creating these resources!

After running `terraform init` and `terraform apply` to create the storage account and container, you can then
configure the backend by uncommenting the backend block in `main.tf`.

> The next time you run it, Terraform will detect the local state file and prompt you to migrate it to the remote
> backend. Follow the prompts to complete the migration!

---

## Update Terraform State After Renaming a Module

When you rename a Terraform module, Terraform sees the new module block as a completely new resource by default. This
means it will try to create new resources and destroy the old ones unless you tell Terraform to map the old state to the
new module. Here’s how to handle it safely.

Suppose you originally had:

```tf
module "old_storage" {
  source              = "./modules/storage_account"
  name                = "myprojectsa"
  resource_group_name = module.rg.name
  location            = module.rg.location
}
```

And you rename it to:

```tf
module "storage_account" {
  source              = "./modules/storage_account"
  name                = "myprojectsa"
  resource_group_name = module.rg.name
  location            = module.rg.location
}
```

Terraform now sees `module.storage_account` as new and `module.old_storage` as orphaned. You need to move the state from
the old module to the new module. To get a list of the current state, run:

```bash
terraform state list
```

You should see something like:

```bash
module.old_storage.azurerm_storage_account.storage_account
```

Then, use the terraform state mv command to rename the module in the state file:

```bash
terraform state mv module.old_storage module.storage_account
```

This tells Terraform that the resources already exist under the new module name, preventing recreation. If you run
`terraform plan` after moving the state, it should show no changes (or only legitimate changes if you
modified the module).