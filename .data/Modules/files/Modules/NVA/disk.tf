
resource "azurerm_managed_disk" "disk" {
    for_each = var.data_disk
  name                 = each.value.name
  location             = data.azurerm_resource_group.resourcegroup.location
  resource_group_name  = data.azurerm_resource_group.resourcegroup.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = each.value.size
  zone = azurerm_virtual_machine.vm.zones[0]
  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "additional_disk_attachment" {
    for_each = var.data_disk
  managed_disk_id    = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = azurerm_virtual_machine.vm.id
  lun                = each.value.lun
  caching            = "None"
  }
