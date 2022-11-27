data "azuredevops_client_config" "current" {}

locals {
  base_url         = data.azuredevops_client_config.current.organization_url
  pool_create_body = jsonencode({
    agentInteractiveUI   = false
    azureId              = var.virtual_machine_scale_set_id
    desiredIdle          = var.desiredIdle
    desiredSize          = var.desiredSize
    maxCapacity          = var.maxCapacity
    maxSavedNodeCount    = 1
    osType               = var.osType
    recycleAfterEachUse  = var.recycleAfterEachUse
    serviceEndpointScope = var.project_id
    sizingAttempts       = 1
    timeToLiveMinutes    = var.timeToLiveMinutes
    state                = "online"
  })
}

resource "shell_script" "pool" {
  lifecycle_commands {
    create = "sh ${path.module}/scripts/pool_http_client.sh create"
    update = "sh ${path.module}/scripts/pool_http_client.sh update"
    delete = "sh ${path.module}/scripts/pool_http_client.sh delete"
  }

  environment = {
    POOL_NAME             = var.name
    PROJECT_ID            = var.project_id
    BASE_URL              = local.base_url
    REQUEST_BODY_JSON     = local.pool_create_body
    SERVICE_ENDPOINT_NAME = var.service_endpoint_name
    VM_SCALE_SET_ID       = var.virtual_machine_scale_set_id
  }
}
