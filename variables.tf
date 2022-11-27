variable "name" {
  type        = string
  description = "The name of this project."
}

variable "template" {
  type        = string
  description = "Specifies the work item template. Valid values: Agile, Basic, CMMI, Scrum."
  default     = "Agile"
}

variable "features" {
  type        = map(string)
  description = "Defines the status (enabled, disabled) of the all project features."
  default     = {
    boards       = "enabled"
    repositories = "enabled"
    pipelines    = "enabled"
    artifacts    = "enabled"
    testplans    = "disabled" # disabled by default because of additional license costs
  }
}

variable "visibility" {
  type        = string
  description = "Specifies the visibility of this project. Valid values: private or public."
  default     = "private"
}

variable "description" {
  type        = string
  description = "The description of this project."
  default     = "Managed by Terraform."
}

variable "security" {
  type = object({
    rbac = optional(map(set(string)), {})
    git  = optional(map(object({
      permissions = map(string)
    })), {})
    project = optional(map(object({
      permissions = map(string)
    })), {})
  })
  description = "Bootstrap oprional security settings for related git and project levels, e.g. RBAC."
  default     = {
    git     = {}
    project = {}
  }
}

variable "repos" {
  type = map(object({
    default_branch                  = optional(string, "refs/heads/main")
    default_branch_policies_enabled = optional(bool, true)
    # setup initial files
    files                           = optional(map(object({
      path    = string
      content = string
    })), {})
    # setup initial pipelines based on initial files
    pipelines = optional(map(string), {})
  }))
  description = "Bootstrap optional GIT repositories incl. e.g. files, pipelines..."
  default     = {}
}

variable "service_endpoints" {
  type = object({
    arm = map(object({
      client_id           = string
      client_secret       = string
      tenant_id           = string
      subscription_id     = string
      subscription_name   = string
      resource_group_name = optional(string)
    }))
  })
  description = "Bootstrap optional service endpoints, e.g. into your private Azure infrastructure."
  default     = {
    arm = {}
  }
}

variable "agent_pools_vmss" {
  type = map(object({
    # pool configuration
    osType                       = optional(string, "linux")
    desiredIdle                  = optional(number, 0)
    desiredSize                  = optional(number, 1)
    maxCapacity                  = optional(number, 3)
    timeToLiveMinutes            = optional(number, 45)
    recycleAfterEachUse          = optional(bool, false)
    # pool meta data
    service_endpoint_name        = string
    virtual_machine_scale_set_id = string
  }))
  description = "Bootstrap optional agent pools, e.g. Virtual Mahine Scale Sets in your private Azure infrastructure."
  default     = {}
}
