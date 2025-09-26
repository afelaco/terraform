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

variable "object_id" {
  description = "Object ID of the user or service principal"
  type = list(
    object(
      {
        user = string
      }
    )
  )
  default = [
    {
      user = "0a909171-669b-492b-bd9b-c1f777a42f23"
    }
  ]
}
