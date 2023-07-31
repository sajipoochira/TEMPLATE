subscription_id = ""

resource_group_name = "rg-shared-hub-qc-001"
vnet_name           = "vnet-hub-qc-001"
subnetname          = "snet-hub-shared-qc-001"
vnet_rg_name        = "rg-network-hub-qc-001"
OSType              = "linux"

virtual_machine = {
  vm1 = {
    name     = "vm-ntp-srv-001"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
    ip_address = "172.29.2.8"
  },
    vm2 = {
    name     = "vm-ntp-srv-002"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
    ip_address = "172.29.2.9"
  },


}
os_image = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "19.10-DAILY"
  version   = "latest"

}

tags = {
  Environment = "MCIT-GOVSS-Hub"
  CreatedBy   = "MCIT-NetworkTeam"
  CreatedOn   = "31-01-2023"
  Owner       = "acadiri@mcit.gov.qa"
  Application = "NTP"
}

