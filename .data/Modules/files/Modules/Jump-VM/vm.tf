############################################
data "azurerm_resource_group" "resourcegroup" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "vnetresourcegroup" {
  name = var.vnet_rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  resource_group_name  = data.azurerm_resource_group.vnetresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.virtualnetwork.name
}

data "azurerm_virtual_network" "virtualnetwork" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnetresourcegroup.name
}

#Creating Virtual Machine ---------------
# --------------------------------------
resource "azurerm_network_interface" "nic-jmp-hub-net" {
  for_each            = var.virtual_machine
  name                = "nic-${each.value["name"]}"
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "InterfaceIP"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm-jmp-hub-net" {
  for_each              = var.virtual_machine
  name                  = each.value["name"]
  location              = data.azurerm_resource_group.resourcegroup.location
  resource_group_name   = data.azurerm_resource_group.resourcegroup.name
  network_interface_ids = [azurerm_network_interface.nic-jmp-hub-net[each.key].id]
  vm_size               = each.value["vm_size"]
  
  # Uncomment this line to delete the disks automatically when deleting the VM
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }
  storage_os_disk {
    name              = "disk-${each.value["name"]}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = each.value["name"]
    admin_username = each.value["username"]
    admin_password = each.value["password"]
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = var.tags

}