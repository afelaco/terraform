variable "project_name" {
  description = "Prefix for resource names"
  type        = string
  default     = "homeauto"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "northeurope"
}

variable "layer" {
  description = "List of storage account layers"
  type = list(string)
  default = ["bronze", "silver", "gold"]
}

variable "tenant_id" {
  description = "The Tenant ID for the Key Vault."
  type        = string
  sensitive   = true
}

variable "user_object_id" {
  description = "The Object ID of the user or service principal to assign access policies."
  type        = string
  sensitive   = true
}

variable "sp_object_id" {
  description = "The Object ID of the user or service principal to assign access policies."
  type        = string
  sensitive   = true
}

variable "external_secrets" {
  description = "Map of external secrets to store in Key Vault"
  type = map(string)
  sensitive   = true
}