locals {
  project = {
    name = "internal_demo"
    repos = {
      java-app = {

      }
    }
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
        Readers = {
          permissions = {
            CreateRepository = "Allow"
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
