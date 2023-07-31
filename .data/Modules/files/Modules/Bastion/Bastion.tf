data "azurerm_resource_group" "bastion"{
    name = var.resource_group_name
    }

data "azurerm_resource_group" "vnet"{
    name = var.vnet_rg_name
    }


#Creating Hub Virtual Network
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet.name

}

#Creating Subnet ---------------
data "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = data.azurerm_resource_group.vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
 
}


#############################################################################
#Creating Azure Bastion host ---------------

resource "azurerm_public_ip" "pip-azure-bastion" {
  name                = "pip-${var.bastion_name}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = var.tags
}

resource "azurerm_bastion_host" "azurebastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.bastion.name
  sku = "Standard"
  shareable_link_enabled = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.pip-azure-bastion.id
  }
  tags = var.tags
}

