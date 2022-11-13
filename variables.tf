variable "project" {
  type = object({
    name        = string
    template    = optional(string, "Basic")
    visibility  = optional(string, "private")
    description = optional(string, "Managed by terraform")
    features    = optional(map(string), {
      boards       = "enabled"
      repositories = "enabled"
      pipelines    = "enabled"
      testplans    = "disabled"
      artifacts    = "disabled"
    })

  })
}
