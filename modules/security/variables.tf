variable "project_id" {
  type        = string
  description = "The id of the created project."
}

variable "git" {
  type = map(object({
    permissions = map(string)
  }))
  description = "The data structure to manage git level permissions."
}

variable "project" {
  type = map(object({
    permissions = map(string)
  }))
  description = "The data structure to manage project level permissions."
}

variable "rbac" {
  type        = map(set(string))
  description = "The data structure to manage RBAC based on built-in group names to Azure AD groups."
}
