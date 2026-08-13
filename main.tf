terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.project
  }
}

resource "azurerm_storage_account" "data_lake" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.lab.name
  location                 = azurerm_resource_group.lab.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.project
  }
}