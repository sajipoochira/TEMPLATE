subscription_id = "1470bf70-a121-4c2f-834b-7b8330e8a84d"

resource_group_name = "rg-mig-test"
vnet_name           = "vnet-mig-test"
vnet_rg_name = ""
subnetnames          = ["vm"]

OSType = "windows"

virtual_machine = {
  vm1 = {
    name     = "vm-test-001"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
   vm2 = {
    name     = "vm-test-002"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
   vm3 = {
    name     = "vm-test-003"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
}
os_image = {
  publisher = "MicrosoftWindowsDesktop"
  offer     = "windows-10"
  sku       = "20h1-evd"
  version   = "latest"
}

tags = {
  Environment = "Hub"
  Project     = "test"
}