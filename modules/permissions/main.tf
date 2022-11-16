
# git level security
#

data "azuredevops_group" "git" {
  for_each = var.git

  name       = each.key
  project_id = var.project_id
}

resource "azuredevops_git_permissions" "git" {
  for_each = var.git

  project_id  = var.project_id
  principal   = data.azuredevops_group.git[each.key].id
  permissions = each.value.permissions
}

# project level security
#

data "azuredevops_group" "project" {
  for_each = var.project

  name       = each.key
  project_id = var.project_id
}

resource "azuredevops_project_permissions" "project" {
  for_each = var.project

  project_id = var.project_id
  principal  = data.azuredevops_group.project[each.key].id
  permissions = each.value.permissions
}
