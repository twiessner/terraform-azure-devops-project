resource "azuredevops_serviceendpoint_azurerm" "arm" {
  project_id            = var.project_id
  service_endpoint_name = var.arm.name
  description           = "Managed by terraform"

  credentials {
    serviceprincipalid  = var.arm.client_id
    serviceprincipalkey = var.arm.client_secret
  }

  azurerm_spn_tenantid          = var.arm.tenant_id
  azurerm_subscription_id       = var.arm.subscription_id
  azurerm_subscription_name     = var.arm.subscription_name
  azurerm_management_group_name = var.arm.resource_group_name
}
