locals {
  nic_names = [for sub in var.subnetnames : split("-", sub)]

   lbnames = var.lb_required ? var.load_balancer.external_lb ? ["lbi-${var.load_balancer.sufix}-hub-qc-001", "lbe-${var.load_balancer.sufix}-hub-qc-001"] : ["lbi-${var.load_balancer.sufix}-hub-qc-001"] : []

  lbname = var.key == "vm1" ? local.lbnames :[]

  lbefipname = [
        {
      name                 = "fip-${var.load_balancer.sufix}-untrust"
      public_ip_address_id = azurerm_public_ip.publicip == [] ? "":azurerm_public_ip.publicip[0].id
    }
  ]
  lbifipname1 = [
    {
      name                          = "fip-${var.load_balancer.sufix}-untrust"
      subnet_id                     = length(var.subnetnames) == 1 ? "" : data.azurerm_subnet.subnet[1].id
      private_ip_address_allocation = "Dynamic"
    },
    {
      name                          = "fip-${var.load_balancer.sufix}-trust"
      subnet_id                     = length(var.subnetnames) > 2 ? data.azurerm_subnet.subnet[2].id : ""
      private_ip_address_allocation = "Dynamic"
    }
  ]

  lbifipname2 = [
    {
      name                          = "fip-${var.load_balancer.sufix}-trust"
      subnet_id                     = length(var.subnetnames) == 1 ? "" :data.azurerm_subnet.subnet[1].id
      private_ip_address_allocation = "Dynamic"
    }
  ]
  lbebackendName = [
   
    {
      name    = "backend-${var.load_balancer.sufix}-untrust"
      id = azurerm_lb.loadbalancer == [] ? "" :azurerm_lb.loadbalancer[0].id
    },
    {
      name    = "backend-${var.load_balancer.sufix}-trust"
      id = azurerm_lb.loadbalancer == [] ? "" :azurerm_lb.loadbalancer[0].id
    },
     {
      name    = "backend-${var.load_balancer.sufix}-untrust"
      id = azurerm_lb.loadbalancer == [] || !var.load_balancer.external_lb ? "" :azurerm_lb.loadbalancer[1].id
    }
  ]
  lbibackendName1 = [
    {
      name    = "backend-${var.load_balancer.sufix}-untrust"
      id = azurerm_lb.loadbalancer == [] ? "" :azurerm_lb.loadbalancer[0].id
    },
    {
      name    = "backend-${var.load_balancer.sufix}-trust"
      id = azurerm_lb.loadbalancer == [] ? "" :azurerm_lb.loadbalancer[0].id
    }
  ]
   lbibackendName2 = [
       {
      name    = "backend-${var.load_balancer.sufix}-trust"
      id = azurerm_lb.loadbalancer == [] ? "" :azurerm_lb.loadbalancer[0].id
    }
  ]

  lbifipname = length(var.subnetnames) > 2 ? local.lbifipname1 : local.lbifipname2
  bkend = length(local.lbname) == 2 ? local.lbebackendName : length(var.subnetnames) > 2 ? local.lbibackendName1 :local.lbibackendName2

}

