
variable "project_id" {
  type = string
}

variable "git" {
  type = map(object({
    permissions = map(string)
  }))
  description = ""
  default = {}
}
