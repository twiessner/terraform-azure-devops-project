# Introduction

This example illustrates the integration of Azure DevOps into an Azure Tenant. The basic functions of

- Service Endpoints
- Agent Pools (Self hosted Virtual Machine Scale Set)

are used, for example, to run Azure pipeline jobs on self-managed, private infrastructure.
Especially in the enterprise environment this feature can be very important
(e.g. data protection or pre-installed software etc.).

# Preparation

In preparation, the following steps must be performed prior:

- Create a service principal in Azure AD with the necessary permissions for the service endpoint.

```bash
# e.g. via Azure cli
az ad sp create-for-rbac \
  --name azure-devops-sc-arm-vmss \
  --role "Virtual Machine Contributor" \
  --scopes /subscriptions/<your suscription id>/resourceGroups/<your resource group name>/providers/Microsoft.Compute/virtualMachineScaleSets/<your vmss name>
```

- Create or use a virtual machine scale set in the Azure infrastructure to which the service principal has access.

Important: These steps are intentionally not part of the module for administration within Azure DevOps.

> Note: The `scope` parameter is very important here to implement the principle of least privilege.
> I suggest to assign permissions only to the Virtual Machine Scale Set itself, not to a higher scope.

# Terraform

For this use case, we use a local backend.

> Note: For productive environments this should not be used, but
> a [remote backend](https://developer.hashicorp.com/terraform/language/settings/backends/configuration).

## Installation

In order to use Terraform in your own environment, you need to install it.
Instructions for this can be found [here](https://developer.hashicorp.com/terraform/downloads).

## Preparation

The configuration of the Terraform Provider `azuredevops`, `azurerm` requires the following information,
which is provided as a local file `_private.auto.tfvars`

```hcl
# Azure AD settings
#
tenant_id         = "<your Azure tenant id>"
subscription_id   = "<your Azure subscription id>"
subscription_name = "<your Azure subscription name>"

# Azure Devops settings
#
devops_org_url = "https://dev.azure.com/<your organisation name>"
devops_org_pat = "<your personal access token>"

client_id     = "service principal client id"
client_secret = "service principal client secret"

vmss_name                = "<name of your vm scale set>"
vmss_resource_group_name = "<name of the resource group where the vmss is located>"
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

- [Setup Virtual Machine Scale Set for Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops)
