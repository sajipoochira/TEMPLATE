resource "azurerm_lb" "loadbalancer" {
  count            = var.key == "vm1" && var.lb_required ? length(local.lbname) :0
  name                = local.lbname[count.index]
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  sku                 = "Standard"
depends_on = [
  azurerm_public_ip.publicip
]

dynamic "frontend_ip_configuration" {
  for_each = range(length(local.lbname[count.index] == "lbe-${var.load_balancer.sufix}-hub-qc-001" ? local.lbefipname : []))
content {
  name                 = local.lbefipname[frontend_ip_configuration.value].name
      public_ip_address_id = local.lbefipname[frontend_ip_configuration.value].public_ip_address_id
}
  
}
dynamic "frontend_ip_configuration" {
  for_each = range(length(local.lbname[count.index] == "lbi-${var.load_balancer.sufix}-hub-qc-001" ?  local.lbifipname : []))
content {
 name                          = local.lbifipname[frontend_ip_configuration.value].name
      subnet_id                     = local.lbifipname[frontend_ip_configuration.value].subnet_id
      private_ip_address_allocation = local.lbifipname[frontend_ip_configuration.value].private_ip_address_allocation
}
  
}

 
  tags = var.tags
}

resource "azurerm_public_ip" "publicip" {
  count               = length(local.lbname) == 2 ? 1 : 0
  name                = "pip-${var.load_balancer.sufix}-untrust"
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_lb_backend_address_pool" "bkend" {
count = azurerm_lb.loadbalancer == [] ? 0 : length(local.bkend)
  loadbalancer_id = local.bkend[count.index].id
  name            = local.bkend[count.index].name
 
}


resource "azurerm_lb_probe" "HB" {
count            = length(local.lbname)
  loadbalancer_id = azurerm_lb.loadbalancer[count.index].id
  name            = "HB"
  port            = 22
  depends_on = [
    azurerm_lb.loadbalancer
  ]
}
resource "azurerm_lb_rule" "rule" {
  count = length(local.lbname)
  loadbalancer_id                = azurerm_lb.loadbalancer[count.index].id
  name                           = replace(azurerm_lb.loadbalancer[count.index].frontend_ip_configuration.0.name,"fip","lbr")
  protocol                       = local.lbname[count.index] != "lbe-${var.load_balancer.sufix}-hub-qc-001" ? "All" : "Tcp"
  frontend_port                  = local.lbname[count.index] != "lbe-${var.load_balancer.sufix}-hub-qc-001" ? 0 : 443
  backend_port                   = local.lbname[count.index] != "lbe-${var.load_balancer.sufix}-hub-qc-001" ? 0  : 443
  frontend_ip_configuration_name = azurerm_lb.loadbalancer[count.index].frontend_ip_configuration.0.name
  backend_address_pool_ids = local.lbname[count.index] != "lbe-${var.load_balancer.sufix}-hub-qc-001" && length(local.bkend) == 3 ? [azurerm_lb_backend_address_pool.bkend[count.index].id]:length(azurerm_lb_backend_address_pool.bkend) == 1 ? [azurerm_lb_backend_address_pool.bkend[count.index].id] :[azurerm_lb_backend_address_pool.bkend[count.index+1].id]
disable_outbound_snat = true
  probe_id = azurerm_lb_probe.HB[count.index].id
depends_on = [
  azurerm_lb.loadbalancer
]
}

resource "azurerm_lb_rule" "rule1" {
  count = azurerm_lb.loadbalancer == [] || length(azurerm_lb_backend_address_pool.bkend) == 1 ? 0: 1
  
  loadbalancer_id                = azurerm_lb.loadbalancer[0].id
  name                           = length(var.subnetnames) > 2 ? replace(azurerm_lb.loadbalancer[0].frontend_ip_configuration.1.name,"fip","lbr") : replace(azurerm_lb.loadbalancer[0].frontend_ip_configuration.0.name,"fip","lbr")
  protocol                       = "All"
  frontend_port                  = 0 
  backend_port                   = 0 
  frontend_ip_configuration_name = length(var.subnetnames) > 2 ? azurerm_lb.loadbalancer[0].frontend_ip_configuration.1.name : azurerm_lb.loadbalancer[0].frontend_ip_configuration.0.name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.bkend[1].id]
disable_outbound_snat = true
  probe_id = azurerm_lb_probe.HB[0].id
depends_on = [
  azurerm_lb.loadbalancer
]

}