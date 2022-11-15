variable "project" {
  type = object({
    name        = string
    template    = optional(string, "Basic")
    visibility  = optional(string, "private")
    description = optional(string, "Managed by terraform")
    features = optional(map(string), {
      boards       = "enabled"
      repositories = "enabled"
      pipelines    = "enabled"
      testplans    = "disabled"
      artifacts    = "disabled"
    })
    security = optional(object({
      git = map(object({
        permissions = map(string)
      }))
    }))
    repos = map(object({
      default_branch = optional(string, "refs/heads/main")
      files = optional(map(object({
        path    = string
        content = string
      })), {})
      pipelines = optional(map(string), {})
    }))
  })
}
