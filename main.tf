# Get current client details
data "azurerm_client_config" "current" {}

# Terraform Backend Configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "homeauto-rg"
    storage_account_name = "homeautotf"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# Terraform Backend Storage Account
resource "azurerm_storage_account" "tf" {
  name                     = "${var.project_name}tf"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "${var.project_name}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Container
resource "azurerm_storage_container" "tfstate" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.tf.name
}

resource "azurerm_storage_container" "steam" {
  name                 = "steam"
  storage_account_name = azurerm_storage_account.sa.name
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                = "${var.project_name}-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.user_object_id
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }
}
