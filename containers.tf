resource "azurerm_storage_container" "data_lake" {
  for_each = var.storage_containers

  name                  = each.value
  storage_account_id    = azurerm_storage_account.data_lake.id
  container_access_type = "private"
}