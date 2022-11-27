provider "azuredevops" {
  org_service_url       = var.devops_org_url
  personal_access_token = var.devops_org_pat
}

provider "shell" {
  sensitive_environment = {
    # Note: required parameter name
    AZURE_DEVOPS_PAT = var.devops_org_pat
  }
}

provider "azurerm" {
  features {}

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
