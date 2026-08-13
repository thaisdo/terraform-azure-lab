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

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "storage_containers" {
  description = "Blob container to create in the storage account"
  type        = set(string)
  default     = ["bronze", "silver", "gold"]
}