terraform {
  backend "azurerm" {
    resource_group_name = "saraterraformstorage" #in value put the storage account rg name
    storage_account_name = "sarablobstorage" #in value replace it with storage account name
    container_name = "saratfstate" #replace it with the container we have created tfstate
    key = "projectx.tfstate" #this is the name of the state file which will be created in the container
  }
}