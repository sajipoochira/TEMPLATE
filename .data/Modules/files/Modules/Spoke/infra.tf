
#Creating Resource Group ---------------
resource "azurerm_resource_group" "resourcegroup" {

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

#Creating NSG ---------------
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.network_settings
  name                = each.value["nsg"]
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  tags                = var.tags
}

resource "azurerm_route_table" "rt" {
  for_each                      = var.network_settings
  name                          = each.value["route_table"]
  location                      = azurerm_resource_group.resourcegroup.location
  resource_group_name           = azurerm_resource_group.resourcegroup.name
  tags                          = var.tags
  disable_bgp_route_propagation = false

  route = var.routes

}
resource "azurerm_subnet_route_table_association" "rt-subnet" {
  for_each       = var.network_settings
  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.rt[each.key].id
}

#Creating Hub Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  address_space       = var.address_space

  tags = var.tags
}

#Creating Subnet ---------------
resource "azurerm_subnet" "subnet" {
  for_each             = var.network_settings
  name                 = each.value["subnet"]
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value["address_prefixes"]
}

#Creating Subnet and NSG Assosiation ---------------
resource "azurerm_subnet_network_security_group_association" "nsg-subnet" {
  for_each                  = var.network_settings
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}


