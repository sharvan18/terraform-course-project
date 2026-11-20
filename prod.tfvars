resource_group_name = "rg-kyn-psara"
location = "eastus"
environment = "prod"
business_unit = "sap"
vnet_name = "kyn-vnet"
vnet_address_space = ["173.16.0.0/16"]

subnets = { #student db
    "subnet1" = { #student1
      name              = "web-subnet-az1"
      address_prefix    = ["173.16.1.0/24"]
      availability_zone = "1"
    }
    "subnet2" = { #student2
      name              = "web-subnet-az2"
      address_prefix    = ["173.16.2.0/24"]
      availability_zone = "2"
    }
}