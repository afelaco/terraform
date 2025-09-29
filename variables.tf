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

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "1d5073f8-a416-4dd0-8cf4-6926871926db"
  sensitive   = true
}

variable "object_id" {
  description = "Object ID of the service principal"
  type        = string
  default     = "05afc1fa-af1e-42cb-96ea-2cb12e3691f1"
  sensitive   = true
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