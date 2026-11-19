resource "azurerm_subnet" "web_subnet" {
    for_each = var.subnets 
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefix
}