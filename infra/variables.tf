#Azure SP cred details
variable "client_id" {}
variable "client_secret" {}
#BIG-IP variables
variable "prefix" {default = "mydemo"}
variable "uname" {default = "azureuser"}
variable "upassword" {default = "DefaultPass12345!"}
variable "location" {default = "East US 2"}
#Network variables
variable "network_cidr" {default = "10.0.0.0/16"}
variable "mgmt_subnet_prefix" {default = "10.0.1.0/24"}
variable "external_subnet_prefix" {default = "10.0.2.0/24"}
variable "internal_subnet_prefix" {default = "10.0.3.0/24"}

variable "aks_cluster_map" {
    type = map
    default = {
      cluster1 = {
        name                = "cluster1"
        service_cidr        = "172.16.0.0/16"
        dns_service_ip      = "172.16.0.10"
        docker_bridge_cidr  = "172.17.0.1/16"
      }
      cluster2 = {
        name                = "cluster2"
        service_cidr        = "172.18.0.0/16"
        dns_service_ip      = "172.18.0.10"
        docker_bridge_cidr  = "172.19.0.1/16"
      }
    }
  }