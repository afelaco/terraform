variable "key_vault_name" {
  description = "The name of the key vault."
  type        = string
}

variable "key_vault_location" {
  description = "The Azure region where the key vault will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID for the Key Vault."
  type        = string
}

variable "user_object_id" {
  description = "The Object ID of the user or service principal to assign access policies."
  type        = string
}

variable "sp_object_id" {
  description = "The Object ID of the user or service principal to assign access policies."
  type        = string
}

variable "external_secrets" {
  type        = map(string)
  description = "All external secrets to sync to Key Vault"
}

