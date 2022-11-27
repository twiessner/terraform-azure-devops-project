variable "project_id" {
  type        = string
  description = "The id of the referenced project."
}

variable "repository_id" {
  type        = string
  description = "The id of the referenced repository."
}

variable "name" {
  type        = string
  description = "The name of this pipeline."
}

variable "file_name" {
  type        = string
  description = "The name of the yaml file for this pipeline."
}

variable "path" {
  type        = string
  description = "The path of the yaml file for this pipeline."
}

variable "default_branch" {
  type        = string
  description = "The branch name of the yaml file for this pipeline."
}
