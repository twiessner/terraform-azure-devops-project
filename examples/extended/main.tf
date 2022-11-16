
data "template_file" "tf_gitignore" {
  template = file("./_templates/terraform.gitignore")
}

data "template_file" "pipeline" {
  template = file("./_templates/azure-pipelines.yaml")
}

locals {
  projects = {
    project1 = {
      name = "Extended-1"
    }
    project2 = {
      name = "Extended-2"
      repos = {
        terraform = {
          files = {
            ".gitignore" = {
              content = data.template_file.tf_gitignore.rendered
              path    = "/"
            }
            "azure-pipelines.yaml" = {
              content = data.template_file.pipeline.rendered
              path    = "/azdo"
            }
          }
          pipelines = {
            Build = "azure-pipelines.yaml"
          }
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
        }
      }
    }
  }
}

# Using the terraform module to manage a single Azure DevOps project.
module "projects" {
  for_each = local.projects
  source = "../../"

  project = each.value
}
