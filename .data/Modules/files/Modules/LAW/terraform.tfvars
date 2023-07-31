#Subscription ID
subscription_id = ""
law_name = "log-sec-ss-hub-qc-001"
law_subnetname = "snet-hub-log-pvl-qc-001"

zones = ["privatelink.monitor.azure.com","privatelink.oms.opinsights.azure.com","privatelink.ods.opinsights.azure.com","privatelink.agentsvc.azure-automation.net", "privatelink.blob.core.windows.net"]


tags = {
  Environment = "MCIT-GOVSS-Hub"
  CreatedBy   = "MCIT-NetworkTeam"
  CreatedOn   = "15-01-2023"
  Owner       = "acadiri@mcit.gov.qa"
    
}


resource_group_name = "rg-sec-hub-qc-001"
vnet_name           = "vnet-hub-qc-001"
subnetname          = "snet-hub-shared-qc-001"
vnet_rg_name        = "rg-network-hub-qc-001"

virtual_machine = {
  vm1 = {
    name     = "vm-cef-log-001"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
  vm2 = {
    name     = "vm-cef-log-002"
    vm_size  = "Standard_D2s_v3"
    username = "LocalAdmin"
    password = "Ch@NgeM31@MweeK"
  },
  
      
}
os_image = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "19.10-DAILY"
  version   = "latest"
  
}

#LoadBalancer

lbname = "lbi-cef-hub-qc-001"
fipname = "fip-cef"
backendName = "bknd-cef-log"
ruleName = "lbr-cef-log"
