resource "azurerm_postgresql_flexible_server" "this" {
  name                          = var.postgres_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.postgres_server_location
  version                       = "12"
  delegated_subnet_id           = azurerm_subnet.example.id
  private_dns_zone_id           = azurerm_private_dns_zone.example.id
  public_network_access_enabled = false
  administrator_login           = var.postgres_server_admin_username
  administrator_password        = var.postgres_server_admin_password
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P30"

  sku_name = "GP_Standard_D4s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name                = var.postgres_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_flexible_server.this.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
