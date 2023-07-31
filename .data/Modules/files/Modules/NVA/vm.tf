############################################
data "azurerm_resource_group" "resourcegroup" {
  name = var.resource_group_name
}

data "azurerm_resource_group" "vnet-rg" {
  name = var.vnet_rg_name
}

data "azurerm_subnet" "subnet" {
  count                = length(var.subnetnames)
  name                 = var.subnetnames[count.index]
  resource_group_name  = data.azurerm_resource_group.vnet-rg.name
  virtual_network_name = data.azurerm_virtual_network.virtualnetwork.name
}

data "azurerm_virtual_network" "virtualnetwork" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet-rg.name
}

#Creating Virtual Machine ---------------
# --------------------------------------
resource "azurerm_network_interface" "nic" {
  count                = length(local.nic_names)
  name                 = "nic-${var.virtual_machine.name}-${local.nic_names[count.index][2]}"
  location             = data.azurerm_resource_group.resourcegroup.location
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = local.nic_names[count.index][2]
    subnet_id                     = data.azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = "Dynamic"

  }
}

resource "azurerm_virtual_machine" "vm" {
  name                         = var.virtual_machine.name
  location                     = data.azurerm_resource_group.resourcegroup.location
  resource_group_name          = data.azurerm_resource_group.resourcegroup.name
  network_interface_ids        = azurerm_network_interface.nic[*].id
  primary_network_interface_id = azurerm_network_interface.nic[0].id
  vm_size                      = var.virtual_machine.vm_size

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
    name              = "disk-${var.virtual_machine.name}-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  
  
  os_profile {
    computer_name  = var.virtual_machine.name
    admin_username = var.virtual_machine.username
    admin_password = var.virtual_machine.password
  }

  plan {
    name      = var.plan.name
    product   = var.plan.product
    publisher = var.plan.publisher
  }


  os_profile_linux_config {

    disable_password_authentication = false
  }


  zones = var.virtual_machine.zone
  tags  = var.tags

}                               