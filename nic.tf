 resource "azurerm_network_interface" "web_nic" {
    for_each = var.subnets
  name                = "nic-${each.key}"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.web_pip[each.key].id
  }
    tags                = local.project_tags
}