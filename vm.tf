resource "azurerm_linux_virtual_machine" "web_vm" {
  for_each             = var.subnets
  name                = "${local.resource_name_prefix}-vm-${each.key}"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  size                = "Standard_F2"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic[each.key].id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #this path.module terraform argument it will look for the file inside the current directroy where the terraform file is located. In this case, it will look for the file inside the ssh_keys folder.
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  custom_data = base64encode(file("${path.module}/app.sh")) #this path.module terraform argument it will look for the file inside the current directroy where the terraform file is located. In this case, it will look for the file inside the app.sh folder.
  tags                = local.project_tags
}