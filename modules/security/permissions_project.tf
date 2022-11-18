
data "azuredevops_group" "project" {
  for_each = var.project

  name       = each.key
  project_id = var.project_id
}

resource "azuredevops_project_permissions" "project" {
  for_each = var.project

  project_id  = var.project_id
  principal   = data.azuredevops_group.project[each.key].id
  permissions = each.value.permissions
}
