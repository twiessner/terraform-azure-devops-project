variable "name" {
  type        = string
  description = "The Project Name."
}

variable "description" {
  type        = string
  description = "The Description of the Project."
}

variable "features" {
  type        = map(string)
  description = "Defines the status (enabled, disabled) of the project features. Valid features are boards, repositories, pipelines, testplans, artifacts"
}

variable "visibility" {
  type        = string
  description = "Specifies the visibility of the Project. Valid values: private or public."
}

variable "template" {
  type        = string
  description = "Specifies the work item template. Valid values: Agile, Basic, CMMI, Scrum or a custom, pre-existing one."
}
