 output "rgname" {
  description = "this is the name of the resource group"
  value = azurerm_resource_group.myrg.name
}

output "location" {
  description = "this is the location of the resource group"
  value = azurerm_resource_group.myrg.location
}

output "venet" {
  description = "this is the location of the resource group"
  value = azurerm_virtual_network.vnet.name
}
