variable "project_id" {
  type        = string
  description = "The id of the referenced project."
}

variable "name" {
  type        = string
  description = "The name of the agent pool to create. Note: Must be unique in the organization."
}

variable "service_endpoint_name" {
  type        = string
  description = "The name of the referenced, existing service endpoint."
}

variable "virtual_machine_scale_set_id" {
  type        = string
  description = "The Azure resource id of the Virtual Machine Scale Set to use."
}

variable "osType" {
  type        = string
  description = "The operating system of the used Virtual Machine Scale Set."
}

variable "desiredIdle" {
  type        = number
  description = "Number of agents to have ready waiting for jobs."
}

variable "desiredSize" {
  type        = number
  description = "The desired size of the pool."
}

variable "maxCapacity" {
  type        = number
  description = "Maximum number of nodes that will exist in the elastic pool."
}

variable "timeToLiveMinutes" {
  type        = number
  description = "The minimum time in minutes to keep idle agents alive."
}

variable "recycleAfterEachUse" {
  type        = bool
  description = "Discard node after each job completes."
}
