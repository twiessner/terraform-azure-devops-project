# providers
#
variable "tenant_id" {
  type    = string
  default = "The uuid of the used tenant."
}

variable "devops_org_url" {
  type        = string
  description = "The full url of the used Azure DevOps organization."
}

variable "devops_org_pat" {
  type        = string
  description = "The used Azure DevOps personal access token for API calls."
}
