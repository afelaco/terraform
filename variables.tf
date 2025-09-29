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

variable "subscription_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "883b4338-8b8b-4634-b2c7-c200e29303b7"
  sensitive   = true
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
  default     = "50e3b1f7-6841-43d4-ac0f-5931b64c9c03"
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
}