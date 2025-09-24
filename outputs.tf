output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "container_name" {
  value = azurerm_storage_container.container.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
