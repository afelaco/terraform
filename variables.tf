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

# variable "sql_admin_password" {
#   description = "SQL admin password"
#   type        = string
#   sensitive   = true
# }
