locals {
  #we will define user defined key
  #when you want to concatinate multiple varaibles together you need to put it inside double quote
  #all the varaibles start with a $ symbol and the varaible should be inside squid bracket
  resource_name_prefix = "${var.environment}-${var.business_unit}"
  #dev-it
  project_tags = { #if i called project_tags it will give me the below output
    environment   = var.environment #dev
    business_unit = var.business_unit #it
    Project       = "kyn"
  }
}