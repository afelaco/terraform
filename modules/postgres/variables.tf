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

variable "postgres_server_admin_username" {
  description = "The administrator username for the PostgreSQL Flexible Server"
  type        = string
}

variable "postgres_server_admin_password" {
  description = "The administrator password for the PostgreSQL Flexible Server"
  type        = string
  sensitive   = true
}

variable "postgres_database_name" {
  description = "The name of the PostgreSQL database to create"
  type        = string
}