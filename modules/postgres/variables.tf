variable "postgres_server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the PostgreSQL Flexible Server"
  type        = string
}

variable "postgres_server_location" {
  description = "The Azure region where the PostgreSQL Flexible Server will be created"
  type        = string
}

variable "key_vault_id" {
    description = "The ID of the Key Vault to store the PostgreSQL admin password"
    type        = string
}

variable "postgres_database_name" {
  description = "The name of the PostgreSQL database to create"
  type        = string
}