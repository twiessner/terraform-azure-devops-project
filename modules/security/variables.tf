
variable "project_id" {
  type = string
}

variable "git" {
  type = map(object({
    permissions = map(string)
  }))
  description = ""
}

variable "project" {
  type = map(object({
    permissions = map(string)
  }))
  description = ""
}

variable "rbac" {
  type        = map(set(string))
  description = ""
}
