
locals {
  routes_rt =concat( [for route in var.routes : [for rt in var.route_table: merge({route_table_name = rt}, route)]]...)
  routes_rt_mgmt =compact([for rt in var.route_table: can(regex( "mgmt",rt))?  rt:null])
  data = data.azurerm_route_table.rt[*].subnets
  subnetids  =concat([for id in local.data : tolist(id)]...)

  subnets = [for id in local.subnetids : split("/",id)[length(split("/",id))-1]]
}

resource "azurerm_route" "udr-rt-hub-reverse" {

  count = length(local.routes_rt)
  
  name                = local.routes_rt[count.index].name
  resource_group_name = data.azurerm_resource_group.rg-network-hub-qc-001.name
  route_table_name    = local.routes_rt[count.index].route_table_name
  address_prefix      = local.routes_rt[count.index].address_prefix
  next_hop_type       = local.routes_rt[count.index].next_hop_type
  next_hop_in_ip_address       = local.routes_rt[count.index].next_hop_type == "VirtualAppliance" ? var.next_hop_in_ip_address : null

  
  }

  resource "azurerm_route" "udr-rt-mgmt-reverse" {

  count = length(local.routes_rt_mgmt)
  
  name                = "udr-azurebastion"
  resource_group_name = data.azurerm_resource_group.rg-network-hub-qc-001.name
  route_table_name    = local.routes_rt_mgmt[count.index]
  address_prefix      = var.bastion_subnet
  next_hop_type       = "VnetLocal"  
  
  }
data "azurerm_route_table" "rt" {

count = length(var.route_table)
name = var.route_table[count.index]
resource_group_name = data.azurerm_resource_group.rg-network-hub-qc-001.name
   
}


data "azurerm_subnet" "sub" {

count = length(local.subnets)
name = local.subnets[count.index]
resource_group_name = data.azurerm_resource_group.rg-network-hub-qc-001.name
   virtual_network_name = var.vnet_name
}
resource "azurerm_route" "udr-rt-hub-self" {

  count = length(var.route_table)
  
  name                = "udr-${local.subnets[count.index]}"
  resource_group_name = data.azurerm_resource_group.rg-network-hub-qc-001.name
  route_table_name    = var.route_table[count.index]
  address_prefix      = data.azurerm_subnet.sub[count.index].address_prefix
  next_hop_type       = "VnetLocal"  

  
  }


output "return" {
  value = local.subnets
}


