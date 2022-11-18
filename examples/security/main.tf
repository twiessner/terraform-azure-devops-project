locals {
  project = {
    # Project name "Security"
    name = "Security"
    security = {
      # Use Azure AD groups to manage built-in group permissions
      rbac = {
        Readers      = ["project-guests"]
        Contributors = ["project-developers", "project-supporters"]
      }
      # Customize the built-in groups for git repository permissions
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
      # Customize the built-in group for common project permissions
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

module "project" {
  source = "../../"

  project = local.project
}
