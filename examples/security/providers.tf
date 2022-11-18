provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azuredevops" {
  org_service_url       = var.devops_org_url
  personal_access_token = var.devops_org_pat
}
