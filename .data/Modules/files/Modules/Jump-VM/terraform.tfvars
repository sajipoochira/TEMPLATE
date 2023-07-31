#Subscription ID
subscription_id = ""

resource_group_name = "rg-mgmt0-hub-qc-001"
vnet_name           = "vnet-hub-qc-001"
subnetname          = "snet-hub-mgmt-t0-qc-001"
vnet_rg_name        = "rg-network-hub-qc-001"

virtual_machine = {
  vm1 = {
    name     = "vm-jump-qc-net"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
   vm2 = {
    name     = "vm-jump-qc-sys"
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
  Environment = "MCIT-GOVSS-Hub"
  CreatedBy   = "MCIT-NetworkTeam"
  CreatedOn   = "16-01-2023"
  Owner       = "acadiri@mcit.gov.qa"
  Application = "Jump-Server"
}