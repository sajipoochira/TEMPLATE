#Subscription ID
subscription_id = ""

#Create Backend  Deatails
/*

az group create --name rg-st-tfstate-qc-001 --location qatarcentral
az storage account create -n stmcittfstatebkend -g rg-st-tfstate-qc-001 -l qatarcentral --sku Standard_LRS
az storage container create -n tfstate --account-name stmcittfstatebkend
az storage account keys list --account-name stmcittfstatebkend

*/

location = ""

network_resource_group = ""

vnet = {
  name          = "",
  address_space = []
}
resource_group_names = []



network_settings = {
  net0 = {
    subnet           = "snet-nva-mgmt-hub-qc-001"
    address_prefixes = ["172.28.80.0/27"]
    nsg              = "nsg-nva-mgmt-hub-qc-001"
    route_table      = "rt-nva-mgmt-hub-qc-001"
  },

  net1 = {
    subnet           = "snet-efw-untrust-hub-qc-001"
    address_prefixes = ["172.28.80.32/28"]
    nsg              = "nsg-efw-untrust-hub-qc-001"
    route_table      = "rt-efw-untrust-hub-qc-001"
  },

  net2 = {
    subnet           = "snet-efw-trust-hub-qc-001"
    address_prefixes = ["172.28.80.48/28"]
    nsg              = "nsg-efw-trust-hub-qc-001"
    route_table      = "rt-efw-trust-hub-qc-001"
  },

  net3 = {
    subnet           = "snet-efw-ha-hub-qc-001"
    address_prefixes = ["172.28.80.64/29"]
    nsg              = "nsg-efw-ha-hub-qc-001"
    route_table      = "rt-efw-ha-hub-qc-001"
  },

  net4 = {
    subnet           = "snet-waf-untrust-hub-qc-001"
    address_prefixes = ["172.28.81.0/24"]
    nsg              = "nsg-waf-untrust-hub-qc-001"
    route_table      = "rt-waf-untrust-hub-qc-001"
  },

  net5 = {
    subnet           = "snet-waf-trust-hub-qc-001"
    address_prefixes = ["172.28.80.80/28"]
    nsg              = "nsg-waf-trust-hub-qc-001"
    route_table      = "rt-waf-trust-hub-qc-001"
  },

  net6 = {
    subnet           = "snet-ifw-untrust-hub-qc-001"
    address_prefixes = ["172.28.80.96/28"]
    nsg              = "nsg-ifw-untrust-hub-qc-001"
    route_table      = "rt-ifw-untrust-hub-qc-001"
  },

  net7 = {
    subnet           = "snet-ifw-trust-hub-qc-001"
    address_prefixes = ["172.28.80.112/28"]
    nsg              = "nsg-ifw-trust-hub-qc-001"
    route_table      = "rt-ifw-trust-hub-qc-001"
  },

  net8 = {
    subnet           = "snet-ifw-ha-hub-qc-001"
    address_prefixes = ["172.28.80.72/29"]
    nsg              = "nsg-ifw-ha-hub-qc-001"
    route_table      = "rt-ifw-ha-hub-qc-001"
  },

  net9 = {
    subnet           = "snet-mgmt-t0-hub-qc-001"
    address_prefixes = ["172.28.80.128/28     "]
    nsg              = "nsg-mgmt-t0-hub-qc-001"
    route_table      = "rt-mgmt-t0-hub-qc-001"
  },

  net10 = {
    subnet           = "snet-mgmt-t0-hub-qc-002"
    address_prefixes = ["172.28.80.144/28"]
    nsg              = "nsg-mgmt-t0-hub-qc-002"
    route_table      = "rt-mgmt-t0-hub-qc-002"
  },

  net11 = {
    subnet           = "snet-mgmt-t1-hub-qc-001"
    address_prefixes = ["172.28.80.160/28     "]
    nsg              = "nsg-mgmt-t1-hub-qc-001"
    route_table      = "rt-mgmt-t1-hub-qc-001"
  },

  net12 = {
    subnet           = "snet-kv-hub-qc-001"
    address_prefixes = ["172.28.80.176/29"]
    nsg              = "nsg-kv-hub-qc-001"
    route_table      = "rt-kv-hub-qc-001"
  },

  net13 = {
    subnet           = "snet-shared-hub-qc-001"
    address_prefixes = ["172.28.80.192/26"]
    nsg              = "nsg-shared-hub-qc-001"
    route_table      = "rt-shared-hub-qc-001"
  },

  net14 = {
    subnet           = "snet-st-mgmt-hub-qc-001"
    address_prefixes = ["172.28.82.0/28"]
    nsg              = "nsg-st-mgmt-hub-qc-001"
    route_table      = "rt-st-mgmt-hub-qc-001"
  },

  net15 = {
    subnet           = "snet-log-pvl-hub-qc-001"
    address_prefixes = ["172.28.82.32/27"]
    nsg              = "nsg-log-pvl-hub-qc-001"
    route_table      = "rt-log-pvl-hub-qc-001"
  },

  net16 = {
    subnet           = "AzureBastionSubnet"
    address_prefixes = ["172.28.82.64/26"]
    nsg              = ""
    route_table      = ""
  },
}


tags = {
  Environment = "Hub"
  CreatedBy   = "NetworkTeam"
  CreatedOn   = "15-01-2023"

}