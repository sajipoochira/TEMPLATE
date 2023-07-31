##  variables

variable "resource_group_name" {

}
variable "location" {

}
variable "virtual_network_name" {

}
variable "address_space" {

}

variable "network_settings" {

  type = map(object({
    subnet           = string
    address_prefixes = list(string)
    nsg              = string
    route_table      = string
  }))

}

variable "subscription_id" {

}

variable "tags" {

}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_in_ip_address = string
    next_hop_type          = string
  }))
}

variable "storage_account_name" {
  
}

variable "storage_account_key" {
  
}

variable "key_tf_state" {
  
}

variable "container_name" {
  
}