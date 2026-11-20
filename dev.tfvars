resource_group_name = "rg-kyn-psara"
location = "eastus"
environment = "dev"
business_unit = "sap"
vnet_name = "kyn-vnet"
vnet_address_space = ["172.16.0.0/16"]

subnets = { #student db
    "subnet1" = { #student1
      name              = "web-subnet-az1"
      address_prefix    = ["172.16.1.0/24"]
      availability_zone = "1"
    }
}