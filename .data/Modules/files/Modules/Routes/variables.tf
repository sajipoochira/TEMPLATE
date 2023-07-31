##  variables

variable "next_hop_in_ip_address" {
  
}

variable "subscription_id" {

}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
  }))
}

variable "route_table" {

  default = []
  
}

variable "resource_group_name" {
  
}
variable "bastion_subnet" {

  default = "0.0.0.0/0"
  
}

variable "vnet_name" {

  default = "vnet-hub-qc-001"
  
}