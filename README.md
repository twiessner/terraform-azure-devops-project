# Introduction

Managing Azure DevOps organizations is always possible via the web interface, but always brings difficulties when
recurring tasks are to be executed according to the same process.

For example: create a project, adjust permissions conforming to the organization's specifications,
roll out standard files and pipelines for automation, etc.... There are many other
aspects that need to be executed in the lifecycle of an administrator.

A scalable solution can provide Infrastructure as Code, which can automate many of these tasks.
This repository provides an easy way to use a module based on [Terraform](https://www.terraform.io) to manage an existing
Azure DevOps organization with a connected Azure Active Directory as an administrator.

## Features

Azure DevOps offers a large set of features, some of which are implemented in Terraform. Of these, the following are currently implemented:

### Supported

- Lifecycle (Create, Update, Delete) of Azure Devops projects
  - Meta data (name, description, features, template, ...)
  - Security (RBAC -> Mapping of Azure AD groups to built-in groups, Project- and GIT permissions)
- Lifecycle (Create, Update, Delete) of repositories
  - branch protection by default (default branch)
  - initial provisioning of files
- Lifecycle (Create, Update, Delete) of pipelines

### Planned

- Integration of [Azure Boards](https://azure.microsoft.com/en-us/products/devops/boards)
- Integration of [Azure Service Connections](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)
  - Variable groups, synchronized from [Azure Key Vault](https://azure.microsoft.com/en-us/products/key-vault/#product-overview)
  - Agent pools using self hosted [Azure Virtual Machine Scale Sets](https://azure.microsoft.com/en-us/products/virtual-machine-scale-sets/#overview)

## Terraform

### Installation

In order to use Terraform in your own environment, you need to install it.
Instructions for this can be found [here](https://developer.hashicorp.com/terraform/downloads).

### Data structure

To be able to use this Terraform module, there are the following configuration options in [variables.tf](./variables.tf).

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

### Examples

> Note: The execution requires at least this administrative privileges:
> - Azure DevOps: **Collection Administrator**
> - Azure Active Directory: **Directory Readers**

Check out running examples [here](./examples), otherwise the easiest way is this:

main.tf
```hcl
terraform {
  required_version = "~> 1.3"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.3.0"
    }
  }
}

provider "azuread" {
  tenant_id = "<your Azure tenant id>"
}

provider "azuredevops" {
  devops_org_url = "https://dev.azure.com/<your organisation name>"
  devops_org_pat = "<your personal access token>"
}

locals {
  project = {
    name = "demo"
  }
}

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
- [Connect Azure DevOps to Azure AD](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/connect-organization-to-azure-ad?view=azure-devops)
