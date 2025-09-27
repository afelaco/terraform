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
  type        = list(string)
  default     = ["bronze", "silver", "gold"]
}