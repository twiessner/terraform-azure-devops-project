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

variable "files" {
  type = map(object({
    path    = string
    content = string
  }))
}

variable "pipelines" {
  type = map(string)
}
