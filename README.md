# Introduction

Managing Azure DevOps organizations is always possible via the web interface, but always brings difficulties when
recurring tasks are to be executed according to the same process.

For example: create a project, adjust permissions conforming to the organization's specifications,
roll out standard files and pipelines for automation, etc.... There are many other
aspects that need to be executed in the lifecycle of an administrator.

A scalable solution can provide Infrastructure as Code, which can automate many of these tasks.
This repository provides an easy way to use a module based on [Terraform](https://www.terraform.io) to manage an existing Azure DevOps organization
as an administrator.

## Terraform

### Installation
In order to use Terraform in your own environment, you need to install it.
Instructions for this can be found [here](https://developer.hashicorp.com/terraform/downloads).

### Data structure
To be able to use this Terraform module, there are the following configuration options in [variables.tf](./variables.tf).

> Note: The scope is intended for exactly 1 project.
> Multiple projects you have to manage in your environment (see [examples](./examples) folder).

```hcl
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
      default_branch = optional(string, "refs/heads/main")
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
```

### Example usage

main.tf
```hcl

# Describe the project configuration, using the documented Data Structure above
locals {
  project = {
    name = "demo"
  }
}

# Using the terraform module to manage a single Azure DevOps project.
module "project" {
  source  = "git::https://github.com/twiessner/terraform-azure-devops-project"

  project = local.project
}
```

# Links

- [Terraform modules](https://developer.hashicorp.com/terraform/language/modules/develop) (Hashicorp developer docs)
- [Azure DevOps Terraform Provider](https://registry.terraform.io/providers/microsoft/azuredevops)
- [Azure DevOps Naming conventions](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#project-names)
  - [Organization](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#organization-names)
  - [Project names](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#project-names)
  - [Repository names](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#azure-repos-tfvc)
