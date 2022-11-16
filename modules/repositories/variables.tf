variable "name" {
  type = string
}

variable "project_id" {
  type = string
}

variable "default_branch" {
  type        = string
  description = ""
}

variable "default_branch_policies_enabled" {
  type        = bool
  description = ""
}

variable "files" {
  type = map(object({
    path    = string
    content = string
  }))
}

variable "pipelines" {
  type = map(string)
}
