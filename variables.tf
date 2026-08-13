variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-terraform-lab"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "Brazil South"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "terraform-azure-lab"
}