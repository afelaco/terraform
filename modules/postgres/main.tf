resource "azurerm_postgresql_flexible_server" "this" {
  name                = var.postgres_server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "15"
  sku_name            = "Standard_B1ms"
  storage_mb          = 32768

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  backup {
    retention_days       = 7
    geo_redundant_backup = "Disabled"
  }

  high_availability {
    mode = "Disabled"
  }

  network {
    public_network_access_enabled = true
    delegated_subnet_id           = var.postgres_subnet_id
  }

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name                = var.postgres_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_flexible_server.this.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
