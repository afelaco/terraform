# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "${var.project_name}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                = "${var.project_name}-kv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Access policy for the current user
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }
}

# Store a secret (SQL password, for instance)
# resource "azurerm_key_vault_secret" "sql_admin_password" {
#   name         = "sql-admin-password"
#   value        = var.sql_admin_password
#   key_vault_id = azurerm_key_vault.kv.id
# }

# Get current client details (needed for Key Vault access policy)
data "azurerm_client_config" "current" {}
