#Subscription ID
subscription_id = ""

resource_group_name = "qcaz-rg-mgmt0-hub-qc-01"
vnet_name           = "qcaz-vnet-hub-001"
subnetname          = "qcaz-snet-mgmt0-hub-qc-01"
vnet_rg_name        = "qcaz-rg-network-hub-01"



virtual_machine = {
  vm1 = {
    name     = "qcazvm-jmp-nt"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
   vm2 = {
    name     = "qcazvm-jmp-sy"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
   
}
os_image = {
  publisher = "MicrosoftWindowsDesktop"
  offer     = "windows-10"
  sku       = "20h1-ent"
  version   = "latest"
}

tags = {
  Environment = "Hub"
  ApplicationName =""
  Projectname ="LZ"
  CostCenter = ""
  BusinessOwner =""
  Tiername =""
  CreatedBy =""
  Createddate =""
  Department=""


}