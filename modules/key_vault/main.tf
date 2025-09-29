resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.key_vault_location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # Set access policy for the service principal.
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id
    secret_permissions = [
      "Get",
      "Set",
    ]
  }
}

# Set external secrets.
resource "azurerm_key_vault_secret" "this" {
  for_each = var.external_secrets

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.this.id
}