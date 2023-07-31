subscription_id = "86d8e890-f055-4744-845f-6382847545ef"

/*storage_account_name = ""
prefix               = "infra"
access_key           = ""
*/



location = "qatarcentral"

network_resource_group = "qcaz-rg-network-hub-01"

vnet = {
  name          = "qcaz-vnet-hub-001",
  address_space = ["10.128.0.0/23"]
}
resource_group_names = ["qcaz-rg-network-hub-01", "qcaz-rg-efw-hub-01", "qcaz-rg-appgw-hub-01", "qcaz-rg-ifw-hub-qc-01", "qcaz-rg-mgmt0-hub-qc-01", "qcaz-rg-mgmt1-hub-qc-01","qcaz-rg-mgmt2-hub-qc-01","qcaz-snet-kv-hub-qc-01", "qcaz-snet-shared-hub-qc-01", "qcaz-rg-monitor-hub-qc-01", "qcaz-rg-bastion-hub-qc-01", "qcaz-rg-bkp-hub-qc-01", "qcaz-rg-st-mgmt-hub-qc-01", "qcaz-rg-apim-hub-qc-01","qcaz-rg-apim-hub-qc-02","qcaz-rg-dns-hub-qc-01"]

network_settings = {
  net0 = {
    subnet           = "qcaz-snet-nvamgmt-hub-qc-01"
    address_prefixes = ["10.128.0.0/27"]
    nsg              = "qcaz-nsg-nvamgmt-hub-qc-01"
    route_table      = "qcaz-rt-nvamgmt-hub-qc-01"
  },

  net1 = {
    subnet           = "qcaz-snet-efwuntrust-hub-qc-01"
    address_prefixes = ["10.128.0.32/28"]
    nsg              = "qcaz-nsg-efwuntrust-hub-qc-01"
    route_table      = "qcaz-rt-efwuntrust-hub-qc-01"
  },

  net2 = {
    subnet           = "qcaz-snet-efwtrust-hub-qc-01"
    address_prefixes = ["10.128.0.48/28"]
    nsg              = "qcaz-nsg-efwtrust-hub-qc-01"
    route_table      = "qcaz-rt-efwtrust-hub-qc-01"
  },

  net3 = {
    subnet           = "qcaz-snet-efwha-hub-qc-01"
    address_prefixes = ["10.128.0.64/29"]
    nsg              = "qcaz-nsg-efwha-hub-qc-01"
    route_table      = "qcaz-rt-efwha-hub-qc-01"
  },

  net4 = {
    subnet           = "qcaz-snet-apgw-hub-qc-01"
    address_prefixes = ["10.128.0.128/25"]
    nsg              = "qcaz-nsg-apgw-hub-qc-01"
    route_table      = "qcaz-rt-apgw-hub-qc-01"
  },

  net5 = {
    subnet           = "qcaz-snet-apgwpvl-hub-qc-01"
    address_prefixes = ["10.128.0.96/27"]
    nsg              = "qcaz-nsg-apgwpvl-hub-qc-01"
    route_table      = "qcaz-rt-apgwpvl-hub-qc-01"
  },

  net6 = {
    subnet           = "qcaz-snet-ifwtrust-hub-qc-01"
    address_prefixes = ["10.128.0.80/28"]
    nsg              = "qcaz-nsg-ifwtrust-hub-qc-01"
    route_table      = "qcaz-rt-ifwtrust-hub-qc-01"
  },

  net7 = {
    subnet           = "qcaz-snet-mgmt0-hub-qc-01"
    address_prefixes = ["10.128.1.0/28"]
    nsg              = "qcaz-nsg-mgmt0-hub-qc-01"
    route_table      = "qcaz-rt-mgmt0-hub-qc-01"
  },

  net8 = {
    subnet           = "qcaz-snet-mgmt0-hub-qc-02"
    address_prefixes = ["10.128.1.16/28"]
    nsg              = "qcaz-nsg-mgmt0-hub-qc-02"
    route_table      = "qcaz-rt-mgmt0-hub-qc-02"
  },

  net9 = {
    subnet           = "qcaz-snet-mgmt1-hub-qc-01"
    address_prefixes = ["10.128.1.32/28"]
    nsg              = "qcaz-nsg-mgmt1-hub-qc-01"
    route_table      = "qcaz-rt-mgmt1-hub-qc-01"
  },

  net10 = {
    subnet           = "qcaz-snet-mgmt2-hub-qc-01"
    address_prefixes = ["10.128.1.48/28"]
    nsg              = "qcaz-nsg-mgmt2-hub-qc-01"
    route_table      = "qcaz-rt-mgmt2-hub-qc-01"
  },

  net11 = {
    subnet           = "qcaz-snet-kv-hub-qc-01"
    address_prefixes = ["10.128.0.72/29"]
    nsg              = "qcaz-nsg-kv-hub-qc-01"
    route_table      = "qcaz-rt-kv-hub-qc-01"
  },

  net12 = {
    subnet           = "qcaz-snet-shared-hub-qc-01"
    address_prefixes = ["10.128.1.64/26"]
    nsg              = "qcaz-nsg-shared-hub-qc-01"
    route_table      = "qcaz-rt-shared-hub-qc-01"
  },

  net13 = {
    subnet           = "qcaz-snet-logpvl-hub-qc-01"
    address_prefixes = ["10.128.1.128/27"]
    nsg              = "qcaz-nsg-logpvl-hub-qc-01"
    route_table      = "qcaz-rt-logpvl-hub-qc-01"
  },

  net14 = {
    subnet           = "qcaz-snet-stmgmt-hub-qc-01"
    address_prefixes = ["10.128.1.160/28"]
    nsg              = "qcaz-nsg-stmgmt-hub-qc-01"
    route_table      = "qcaz-rt-stmgmt-hub-qc-01"
  },

  net15 = {
    subnet           = "AzureBastionSubnet"
    address_prefixes = ["10.128.1.192/26"]
     nsg              = ""
    route_table      = ""
  },

  net16 = {
    subnet           = "qcaz-snet-apim-hub-qc-01"
    address_prefixes = ["10.128.2.0/27"]
    nsg              = "qcaz-nsg-apim-hub-qc-01"
    route_table      = "qcaz-rt-apim-hub-qc-01"
  },

  net17 = {
    subnet           = "qcaz-snet-apim-hub-qc-02"
    address_prefixes = ["10.128.2.32/27"]
    nsg              = "qcaz-nsg-apim-hub-qc-02"
    route_table      = "qcaz-rt-apim-hub-qc-02"
  },

 

  net18 = {
    subnet           = "qcaz-snet-dns-hub-qc-01"
    address_prefixes = ["10.128.2.64/28"]
    nsg              = "qcaz-nsg-dns-hub-qc-01"
    route_table      = "qcaz-rt-dns-hub-qc-01"
  },
 
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