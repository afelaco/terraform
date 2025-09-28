resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "this" {
  name         = "POSTGRES-ADMIN-PASSWORD"
  value        = random_password.this.result
  key_vault_id = var.key_vault_id
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.postgres_server_name
  resource_group_name    = var.resource_group_name
  location               = var.postgres_server_location
  version                = "14"
  administrator_login    = var.postgres_server_admin
  administrator_password = random_password.this.result

  storage_mb   = 32768
  storage_tier = "P4"

  sku_name = "B_Standard_B1ms"
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.postgres_database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
