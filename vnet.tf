resource "azurerm_virtual_network" "vnet" {
  #name                = "sara-terraform-vnet"
  #location            = azurerm_resource_group.myrg.location
  #resource_group_name = azurerm_resource_group.myrg.name
  #address_space       = ["10.0.0.0/16"]
  name                = "${local.resource_name_prefix}-${var.vnet_name}" #this is the name of the virtual network
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = var.vnet_address_space
  tags     = local.project_tags
}