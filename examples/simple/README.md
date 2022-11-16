
# Introduction

This example acts as a standalone [Terraform](https://www.terraform.io) project that uses the module to manage a single use case.

- Manage (create, update, delete) a single project
- Customize the built-in Group `Contributors` to allow some git some permissions
  - ForcePush
  - CreateRepository
  - DeleteRepository
  - RenameRepository
- Customize the built-in group `Contributors` to allow some project level permissions
  -  DELETE

> Note: customizing the permissions for built-in groups in Azure DevOps can help implement the principle of `least privilege`
> because you can eliminate the need for the `Project Administrator` group.

# Terraform

> Note: For this use case, we only use a local backend.
> For productive environments this should not be used, but [remote backend](https://developer.hashicorp.com/terraform/language/settings/backends/configuration).

## Installation
In order to use Terraform in your own environment, you need to install it.
Instructions for this can be found [here](https://developer.hashicorp.com/terraform/downloads).

## Preparation

The configuration of the Terraform Provider `azuredevops` requires the following information,
which is provided as a local file `_private.auto.tfvars`

```hcl

# Azure Devops settings
#
devops_org_url = "https://dev.azure.com/<your organisation name>"
devops_org_pat = "<your personal access token>"
```

## Initialization

```bash
terraform init -upgrade
```

## Create resources

```bash
terraform apply
```

## Clean up resources

```bash
terraform destroy
```

# Links

- [GIT level permissions](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/git_permissions)
- [Project level permissions](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project_permissions)
