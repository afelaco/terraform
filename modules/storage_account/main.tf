# Storage Account
resource "azurerm_storage_account" "sa" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Container
resource "azurerm_storage_container" "steam" {
  name                 = "steam"
  storage_account_name = azurerm_storage_account.sa.name
}
