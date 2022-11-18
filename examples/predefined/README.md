
# Introduction

This example acts as a standalone [Terraform](https://www.terraform.io) project that uses the module to manage this use cases:

- Manage (create, update, delete) a project **Predefined-Java**
  - Manage (create, update, delete) a repository `java-application`
    - deploy sample (test) files
- Manage (create, update, delete) a project **Predefined-Pipeline**
  - Manage (create, update, delete) a repository `terraform`
    - deploy sample (test) files
    - deploy a pipeline, based on a yaml file

# Terraform
For this use case, we use a local backend.

> Note: For productive environments this should not be used, but a [remote backend](https://developer.hashicorp.com/terraform/language/settings/backends/configuration).

## Installation
In order to use Terraform in your own environment, you need to install it.
Instructions for this can be found [here](https://developer.hashicorp.com/terraform/downloads).

## Preparation

The configuration of the Terraform Provider `azuredevops` requires the following information,
which is provided as a local file `_private.auto.tfvars`

```hcl
# Azure AD settings
#
tenant_id = "<your Azure tenant id>"

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

- [Azure Pipeline documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/?view=azure-devops)
