output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.lab.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.lab.location
}

output "resource_group_id" {
  description = "Resource ID of the resource group"
  value       = azurerm_resource_group.lab.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.data_lake.name
}

output "storage_account_id" {
  description = "Resource ID of the storage account"
  value       = azurerm_storage_account.data_lake.id
}