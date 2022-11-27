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
    Predefined-Java = {
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
    Predefined-Pipeline = {
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

  name  = each.key
  repos = each.value.repos
}
