resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.key_vault_location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  enable_rbac_authorization = true

}

# Assign Key Vault Secrets User role to the Service Principal.
resource "azurerm_role_assignment" "this" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.object_id
}

# Set external secrets.
resource "azurerm_key_vault_secret" "this" {
  for_each = var.external_secrets

  depends_on   = [azurerm_role_assignment.this]
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.this.id
}