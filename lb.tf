resource "azurerm_public_ip" "web_pip" {
  
  name                 = "${local.resource_name_prefix}-lbpublicip"
  resource_group_name  = azurerm_resource_group.myrg.name
    location            = azurerm_resource_group.myrg.location
  allocation_method    = "Static"
  sku                  = "Standard"
  tags = local.project_tags
}
#we are displaying the public ip address of the load balancer in the output.tf file. This is useful for testing and verification purposes. The output will be displayed after the terraform apply command is executed.
output "lb_public_ip" {
  value = azurerm_public_ip.web_pip.ip_address
}

#we will create the lb
resource "azurerm_lb" "weblb" {
 name                 = "${local.resource_name_prefix}-lb"
  resource_group_name  = azurerm_resource_group.myrg.name
    location            = azurerm_resource_group.myrg.location

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.web_pip.id
  }
}

#we need to create backend address pool for the lb 
resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.weblb.id
  name            = "BackEndAddressPool"
}
resource "azurerm_lb_probe" "lb_health_probe" {
  loadbalancer_id = azurerm_lb.weblb.id
  name            = "HealthProbe"
  protocol        = "Tcp"
  port            = 80 #in instance port number 80
  #protocol       = "Http"
  #path            = "/var/www/html/index.html" #this is the path of the health probe. This is the
  interval_in_seconds = 30 #every 30 second it will check health of your instance in port 80
  number_of_probes    = 2 #if any of the instance do not respond in 1 min it will make that instance unhealthy and it will not send traffic to that instance. It will send traffic to the healthy instance.
}

#rules for the lb
resource "azurerm_lb_rule" "lb_rule" {
    loadbalancer_id            = azurerm_lb.weblb.id
    name                       = "HTTPRule"
    protocol                   = "Tcp"
    frontend_port              = 80 #lb frontend port number 80 443
    backend_port               = 80 #application respond if it is tomcat
    frontend_ip_configuration_name = azurerm_lb.weblb.frontend_ip_configuration[0].name
    backend_address_pool_ids    = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
    probe_id                   = azurerm_lb_probe.lb_health_probe.id
    }

    ##finally we need attach the nic card behind the pool
    resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_pool_assoc" {
        for_each = var.subnets
  network_interface_id    = azurerm_network_interface.web_nic[each.key].id
  ip_configuration_name = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}