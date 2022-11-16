variable "project" {
  type = object({
    # settings for common metadata
    name        = string
    template    = optional(string, "Agile")
    visibility  = optional(string, "private")
    description = optional(string, "Managed by terraform")
    # setup allowed project features
    features = optional(map(string), {
      boards       = "enabled"
      repositories = "enabled"
      pipelines    = "enabled"
      artifacts    = "enabled"
      testplans    = "disabled" # disabled by default because of additional licence cost
    })
    # settings for security customizing
    security = optional(object({
      git = optional(map(object({
        permissions = map(string)
      })), {})
      project = optional(map(object({
        permissions = map(string)
      })), {})
      }), {
      git     = {}
      project = {}
    })
    # settings for git repositories
    repos = optional(map(object({
      default_branch                  = optional(string, "refs/heads/main")
      default_branch_policies_enabled = optional(bool, true)
      # setup initial files
      files = optional(map(object({
        path    = string
        content = string
      })), {})
      # setup initial pipelines based on initial files
      pipelines = optional(map(string), {})
    })), {})
  })
}
