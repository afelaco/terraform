data "azuread_user" "this" {
  user_principal_name = "alessandro.felaco.91_gmail.com#EXT#@alessandrofelaco91gmail.onmicrosoft.com"
}

resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.key_vault_location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azuread_user.this.object_id
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
    ]
  }
}
