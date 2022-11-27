variable "project_id" {
  type        = string
  description = "The id of the referenced project."
}

variable "arm" {
  type = object({
    name                = string
    client_id           = string
    client_secret       = string
    tenant_id           = string
    subscription_id     = string
    subscription_name   = string
    resource_group_name = string
  })
  description = "The configuration for ARM based service endpoints."
}
