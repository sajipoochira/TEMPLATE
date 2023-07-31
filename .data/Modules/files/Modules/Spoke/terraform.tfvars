#Subscription ID
subscription_id = "1470bf70-a121-4c2f-834b-7b8330e8a84d"

#Backend Configuration Deatails

#az group create --name rg-st-tfstate-qc-001 --location qatarcentral
#az storage account create -n stmcittfstatebackend -g rg-st-tfstate-qc-001 -l qatarcentral --sku Standard_LRS
#az storage account keys list --account-name stmcittfstatebackend
#az storage container create -n tfstate --account-name stmcittfstatebackend
storage_account_name = "stmcittfstatebackend"
storage_account_key = "JtIdYr9UmUt7VuVRCCxDQv+e5Py8em2ioLOZX48Y7vERHgK7vGl6ozqCf3Q8GBXeY+b2xxwnaIft+ASt08jmsA=="
container_name = "tfstate"
key_tf_state = "prod.terraform.tfstate"



resource_group_name = "rg-app-weu-001"
location            = "westeurope"

virtual_network_name = "vnet-app-weu-001"
address_space        = ["172.20.34.0/26"]

network_settings = {
  net1 = {
    subnet           = "snet-web-prod"
    address_prefixes = ["172.20.34.0/28"]
    nsg              = "nsg-web-prod"
    route_table      = "rt-web-prod"
  },
  net2 = {
    subnet           = "snet-app-prod"
    address_prefixes = ["172.20.34.16/28"]
    nsg              = "nsg-app-prod"
    route_table      = "rt-app-prod"
  },
  net3 = {
    subnet           = "snet-db-prod"
    address_prefixes = ["172.20.34.32/28"]
    nsg              = "nsg-db-prod"
    route_table      = "rt-db-prod"
  },
}

tags = {
  Env = "Prod"
}

routes = [
  {
    name                   = "udr-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_in_ip_address = "172.20.30.150"
    next_hop_type          = "VirtualAppliance"
  },
  {

    name                   = "udr-rfc-01",
    address_prefix         = "10.0.0.0/8",
    next_hop_in_ip_address = "172.28.32.150",
    next_hop_type          = "VirtualAppliance"

  },
  {

    name                   = "udr-rfc-02",
    address_prefix         = "172.16.0.0/12",
    next_hop_in_ip_address = "172.28.32.150",
    next_hop_type          = "VirtualAppliance"

  },
  {

    name                   = "udr-rfc-03",
    address_prefix         = "192.168.0.0/16",
    next_hop_in_ip_address = "172.28.32.150",
    next_hop_type          = "VirtualAppliance"

  },
  {

    name                   = "udr-rfc-04",
    address_prefix         = "100.64.0.0/10",
    next_hop_in_ip_address = "172.28.32.150",
    next_hop_type          = "VirtualAppliance"

  }

]
