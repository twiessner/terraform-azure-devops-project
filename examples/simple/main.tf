
locals {
  project = {
    name = "simple"
    security = {
      git = {
        Contributors = {
          permissions = {
            ForcePush        = "Allow"
            CreateRepository = "Allow"
            DeleteRepository = "Allow"
            RenameRepository = "Allow"
          }
        }
      }
      project = {
        Contributors = {
          permissions = {
            DELETE = "Allow"
          }
        }
      }
    }
  }
}

# Using the terraform module to manage a single Azure DevOps project.
module "project" {
  source = "../../"

  project = local.project
}
