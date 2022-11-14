data "azuredevops_group" "group" {
  for_each = var.git

  name       = each.key
  project_id = var.project_id
}

resource "azuredevops_git_permissions" "permissions" {
  for_each = var.git

  project_id  = var.project_id
  principal   = data.azuredevops_group.group[each.key].id
  permissions = each.value.permissions
}
