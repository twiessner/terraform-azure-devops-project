locals {
  # transform the original to a flat structure
  mapped_rbac_structure = flatten([
    for k, v in var.rbac : [
      for group in v : {
        azdo_group_name = k
        aad_group_name  = group
      }
    ]
  ])
  # use the resulting map of unique group information
  rbac = { for v in local.mapped_rbac_structure : "${v.azdo_group_name}-${v.aad_group_name}" => v }
}


data "azuread_group" "aad" {
  for_each = local.rbac

  display_name = each.value.aad_group_name
}

data "azuredevops_group" "azdo" {
  for_each = local.rbac

  name       = each.value.azdo_group_name
  project_id = var.project_id
}

resource "azuredevops_group" "azdo_aad" {
  for_each = local.rbac

  origin_id = data.azuread_group.aad[each.key].object_id
}

resource "azuredevops_group_membership" "members" {
  for_each = local.rbac

  group   = data.azuredevops_group.azdo[each.key].descriptor
  members = flatten(values(azuredevops_group.azdo_aad)[*].descriptor)
}
