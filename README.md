# terraform

This repository contains Terraform configurations to provision and manage Azure resources.

---

## 1. Setup & Migrate Terraform State to Remote Backend

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