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

# Users
variable "object_id" {
  description = "Object ID of the user"
  type        = string
  default     = "0a909171-669b-492b-bd9b-c1f777a42f23"
}