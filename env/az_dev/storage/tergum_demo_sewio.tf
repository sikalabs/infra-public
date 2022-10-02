resource "azurerm_resource_group" "tergum_demo_sewio" {
  name     = "tergum_demo_sewio"
  location = local.location
}

resource "azurerm_storage_account" "tergum_demo_sewio" {
  name                     = "tergumdemosewio"
  resource_group_name      = azurerm_resource_group.tergum_demo_sewio.name
  location                 = azurerm_resource_group.tergum_demo_sewio.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tergum_demo_sewio" {
  name                  = "backups"
  storage_account_name  = azurerm_storage_account.tergum_demo_sewio.name
  container_access_type = "private"
}


output "tergum_demo_sewio_storage_account_name" {
  value = azurerm_storage_account.tergum_demo_sewio.name
}

output "tergum_demo_sewio_storage_container_name" {
  value = azurerm_storage_container.tergum_demo_sewio.name
}

output "tergum_demo_sewio_primary_access_key" {
  value     = azurerm_storage_account.tergum_demo_sewio.primary_access_key
  sensitive = true
}
