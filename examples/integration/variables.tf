# providers
#
variable "tenant_id" {
  type    = string
  default = "The uuid of the used tenant."
}

variable "subscription_id" {
  type    = string
  default = "The uuid of the used subscription."
}

variable "subscription_name" {
  type    = string
  default = "The name of the used subscription."
}

variable "client_id" {
  type        = string
  description = "The client id of the used service principal for the service endpoint."
}

variable "client_secret" {
  type        = string
  description = "The client secret of the used service principal for the service endpoint."
}

variable "devops_org_url" {
  type        = string
  description = "The full url of the used Azure DevOps organization."
}

variable "devops_org_pat" {
  type        = string
  description = "The used Azure DevOps personal access token for API calls."
}

#
#
variable "vmss_name" {
  type        = string
  description = "The name of the used Virtual Machine Scale Set to connect as agent pool."
}

variable "vmss_resource_group_name" {
  type        = string
  description = "The resource group name of the used Virtual Machine Scale Set to connect as agent pool."
}
