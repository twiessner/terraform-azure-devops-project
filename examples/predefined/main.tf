
data "template_file" "java_gitignore" {
  template = file("./_templates/java.gitignore")
}

data "template_file" "java_class" {
  template = file("./_templates/java.helloWorld")
}

data "template_file" "tf_gitignore" {
  template = file("./_templates/terraform.gitignore")
}

data "template_file" "pipeline" {
  template = file("./_templates/azure-pipelines.yaml")
}

locals {
  projects = {
    project1 = {
      name = "Predefined-Java"
      repos = {
        java-application = {
          files = {
            ".gitignore" = {
              content = data.template_file.java_gitignore.rendered
              path    = "/"
            }
            "HelloWorld.java" = {
              content = data.template_file.java_class.rendered
              path    = "/src/main"
            }
          }
        }
      }
    }
    project2 = {
      name = "Predefined-Pipeline"
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
    }
  }
}

module "projects" {
  for_each = local.projects
  source   = "../../"

  project = each.value
}
