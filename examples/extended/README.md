
# Introduction

This example acts as a standalone [Terraform](https://www.terraform.io) project that uses the module to manage an extended use case.

- Manage (create, update, delete) multiple projects
  - just a simple, empty project
  - complex project including files, pipelines

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
