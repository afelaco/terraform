resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.postgres_server_name
  location               = var.postgres_server_location
  resource_group_name    = var.resource_group_name
  version                = "14"
  administrator_login    = var.postgres_database_admin_username
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

# Store the admin username and password in Azure Key Vault
resource "azurerm_key_vault_secret" "pg_admin" {
  name         = "${upper(azurerm_postgresql_flexible_server.this.name)}-ADMIN-USERNAME"
  value        = azurerm_postgresql_flexible_server.this.administrator_login
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "pg_admin_password" {
  name         = "${upper(azurerm_postgresql_flexible_server.this.name)}-ADMIN-PASSWORD"
  value        = azurerm_postgresql_flexible_server.this.administrator_password
  key_vault_id = var.key_vault_id
}