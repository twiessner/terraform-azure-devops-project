# Introduction

Managing Azure DevOps organizations is always possible via the web interface, but always brings difficulties when
recurring tasks are to be executed according to the same process.

For example: create a project, adjust permissions conforming to the organization's specifications,
roll out standard files and pipelines for automation, etc.... There are many other
aspects that need to be executed in the lifecycle of an administrator.

A scalable solution can provide Infrastructure as Code, which can automate many of these tasks.
This repository provides an easy way to use a module based on [Terraform](https://www.terraform.io) to manage an
existing
Azure DevOps organization with a connected Azure Active Directory as an administrator.

## Features

Azure DevOps offers a large set of features, some of which are implemented in Terraform. Of these, the following are
currently implemented:

### Supported

- Lifecycle (Create, Update, Delete) of Azure Devops projects
  - Meta data (name, description, features, template, ...)
  - Security (RBAC -> Mapping of Azure AD groups to built-in groups, Project- and GIT permissions)
- Lifecycle (Create, Update, Delete) of repositories
  - branch protection by default (default branch)
  - initial provisioning of files
- Lifecycle (Create, Update, Delete) of pipelines
- Lifecycle (Create, Update, Delete)
  of [Azure Service Connections](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)
  - [Azure Resource Manager](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops)
- Lifecycle (Create, Update, Delete) of Agent pools
  - [Azure Virtual Machine Scale Sets](https://azure.microsoft.com/en-us/products/virtual-machine-scale-sets/#overview)

### Planned

- Integration of [Azure Boards](https://azure.microsoft.com/en-us/products/devops/boards)
- Integration
  of [Azure Service Connections](https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)
  - Variable groups, synchronized
    from [Azure Key Vault](https://azure.microsoft.com/en-us/products/key-vault/#product-overview)

## Terraform

### Installation

In order to use Terraform in your own environment, you need to install it.
Instructions for this can be found [here](https://developer.hashicorp.com/terraform/downloads).

### Configuration

To be able to use this Terraform module, there are the following [configuration options](./TERRAFORM.md).
The configuration is designed to be flexible so that only the settings that match the corresponding use case are
necessary.

### Examples

> Note: The execution requires at least this administrative privileges:
> - Azure DevOps
    >

- Collection Administrator

> - Azure Active Directory
    >

- Directory Readers

> - Azure DevOps Administrator

Check out different running examples [here](./examples), otherwise the easiest way is to create a file `main.tf`

```hcl
terraform {
  required_version = "~> 1.3"

  required_providers {
    shell = {
      source = "scottwinkler/shell"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
    }
  }
}

# Initialize providers
#
provider "azuread" {
  tenant_id = "<your Azure tenant id>"
}

provider "azuredevops" {
  devops_org_url = "https://dev.azure.com/<your organisation name>"
  devops_org_pat = "<your personal access token>"
}

provider "shell" {
  sensitive_environment = {
    # Note: required parameter name
    AZURE_DEVOPS_PAT = "<your personal access token>"
  }
}

module "project" {
  source = "git::https://github.com/twiessner/terraform-azure-devops-project"

  name = "Demo"
}
```

then execute in a shell

```bash
terraform init -upgrade
terraform apply
```

# Links

- [Terraform modules](https://developer.hashicorp.com/terraform/language/modules/develop) (Hashicorp developer docs)
- [Azure DevOps Terraform Provider](https://registry.terraform.io/providers/microsoft/azuredevops)
- [Azure DevOps Naming conventions](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#project-names)
  - [Organization](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#organization-names)
  - [Project names](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#project-names)
  - [Repository names](https://learn.microsoft.com/en-us/azure/devops/organizations/settings/naming-restrictions?view=azure-devops#azure-repos-tfvc)
- [Connect Azure DevOps to Azure AD](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/connect-organization-to-azure-ad?view=azure-devops)
