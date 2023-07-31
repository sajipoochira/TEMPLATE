###############################################
#Creating Network Resource Group ---------------
resource "azurerm_resource_group" "networkrg" {

  name     = var.network_resource_group
  location = var.location
  tags     = var.tags
}

#Creating NSG ---------------
resource "azurerm_network_security_group" "nsg" {

  for_each            = { for network_settings_object, value in var.network_settings : network_settings_object => value if value["nsg"] != "" }
  name                = each.value["nsg"]
  location            = azurerm_resource_group.networkrg.location
  resource_group_name = azurerm_resource_group.networkrg.name
  tags                = var.tags


  security_rule = each.value["subnet"] == "AzureBastionSubnet" ? local.security_rule : ([])


}


#Creating route tables ----------------

resource "azurerm_route_table" "rt" {

  for_each                      = { for network_settings_object, value in var.network_settings : network_settings_object => value if value["route_table"] != "" }
  name                          = each.value["route_table"]
  location                      = azurerm_resource_group.networkrg.location
  resource_group_name           = azurerm_resource_group.networkrg.name
  disable_bgp_route_propagation = false

  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "rt-subnet" {
  for_each       = { for network_settings_object, value in var.network_settings : network_settings_object => value if value["route_table"] != "" }
  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.rt[each.key].id
}

#Creating Hub Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = azurerm_resource_group.networkrg.location
  resource_group_name = azurerm_resource_group.networkrg.name
  address_space       = var.vnet.address_space

  tags = var.tags
}

#Creating Subnet ---------------
resource "azurerm_subnet" "subnet" {
  for_each             = var.network_settings
  name                 = each.value["subnet"]
  resource_group_name  = azurerm_resource_group.networkrg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value["address_prefixes"]
}


#Creating Subnet and NSG Assosiation ---------------
resource "azurerm_subnet_network_security_group_association" "nsg-subnet" {
  for_each                  = { for network_settings_object, value in var.network_settings : network_settings_object => value if value["nsg"] != "" }
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}



#Creating Resource Groups ---------------
resource "azurerm_resource_group" "rg" {
  count = length(var.resource_group_names)

  name     = var.resource_group_names[count.index]
  location = var.location
  tags     = var.tags
}
