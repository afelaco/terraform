resource "azurerm_key_vault" "kv" {
  name                = var.name
  tenant_id           = var.tenant_id
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.user_object_id
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }
}
