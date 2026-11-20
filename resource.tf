resource "azurerm_resource_group" "myrg" {
  #name     = "sara-vm_group"
  #name = var.resource_group_name
  #location = "eastus"
  name     = "${local.resource_name_prefix}-${var.resource_group_name}"
  location = var.location
  tags     = local.project_tags
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
