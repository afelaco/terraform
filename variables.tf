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

variable "external_secrets" {
  description = "Map of external secrets to store in Key Vault"
  type = map(string)
  sensitive   = true
}