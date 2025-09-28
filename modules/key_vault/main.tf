resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.key_vault_location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # Set access policy for the user account.
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.user_object_id
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
    ]
  }

  # Set access policy for the service principal.
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.sp_object_id
    secret_permissions = [
      "Get",
      "Set",
    ]
  }
}
