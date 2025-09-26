# Get current client details
data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
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
resource "azurerm_storage_container" "container" {
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
    object_id = var.object_id.user
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }
}
