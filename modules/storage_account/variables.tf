variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "storage_account_location" {
  description = "The Azure region where the storage account will be created."
  type        = string
}

variable "container_name" {
  description = "List of storage container names to create within the storage account."
  type        = list(string)
  default     = ["steam"]
}
