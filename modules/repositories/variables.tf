variable "project_id" {
  type        = string
  description = "The id of the created project."
}

variable "name" {
  type        = string
  description = "The name of the git repository."
}

variable "default_branch" {
  type        = string
  description = "The name of the default branch to create."
}

variable "default_branch_policies_enabled" {
  type        = bool
  description = "Switch to enable the branch protection."
}

variable "files" {
  type = map(object({
    path    = string
    content = string
  }))
  description = "The data structure for files to create."
}

variable "pipelines" {
  type        = map(string)
  description = "The data structure for pipelines to create, e.g. <Pipeline Name> = <yaml file name>"
}
