subscription_id = ""

resource_group_name = "rg-shared-hub-qc-001"
vnet_name           = "vnet-hub-qc-001"
subnetname          = "snet-hub-shared-qc-001"
vnet_rg_name        = "rg-network-hub-qc-001"
OSType              = "windows"

virtual_machine = {
  vm1 = {
    name     = "vm-dns-fwdr-001"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
    ip_address = "172.29.2.11"
  },
   vm2 = {
    name     = "vm-dns-fwdr-002"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
    ip_address = "172.29.2.12"
  },
  
      
}
os_image = {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2019-Datacenter"
  version   = "latest"
}

tags = {
  Environment = "MCIT-GOVSS-Hub"
  CreatedBy   = "MCIT-NetworkTeam"
  CreatedOn   = "16-01-2023"
  Owner       = "acadiri@mcit.gov.qa"
  Application = "DNS"
}

