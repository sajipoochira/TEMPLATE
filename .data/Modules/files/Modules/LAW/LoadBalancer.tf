resource "azurerm_lb" "locadbalancer" {
  name                = var.lbname
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  sku                  = "Standard"
  

  frontend_ip_configuration {
    name                 = var.fipname
    subnet_id           = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"

  }

    tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bkend" {
  
  loadbalancer_id     = azurerm_lb.locadbalancer.id
  name                = var.backendName
}


resource "azurerm_lb_probe" "HB" {
  
  loadbalancer_id     = azurerm_lb.locadbalancer.id
  name                = "HB"
  port                = 22
}

resource "azurerm_lb_rule" "rule" {
  
  loadbalancer_id                = azurerm_lb.locadbalancer.id
  name                           = var.ruleName
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = azurerm_lb.locadbalancer.frontend_ip_configuration.0.name
  
  probe_id 			= azurerm_lb_probe.HB.id
}
