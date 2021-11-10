module "vnet" {
  source = "./vnet"
  #variables for resource creation
  location = var.location
  rg_name = "${var.prefix}-rg"
  network_cidr = var.network_cidr
  mgmt_subnet_prefix = var.mgmt_subnet_prefix
  external_subnet_prefix = var.external_subnet_prefix
  internal_subnet_prefix = var.internal_subnet_prefix
  # Configure the Azure Provider
  client_id	    = var.client_id
  client_secret   = var.client_secret
}

module "aks" {
  for_each = var.aks_cluster_map
  source = "./aks"
  #variables for resource creation
  int_subnet_id = module.vnet.internal_subnet_id
  location = module.vnet.rg_location
  cluster_name = each.value.name
  prefix = "${var.prefix}-${var.prefix}"
  rg_name = module.vnet.rg_name
  service_cidr = each.value.service_cidr
  dns_service_ip = each.value.dns_service_ip
  docker_bridge_cidr = each.value.docker_bridge_cidr 
  #Configure the Azure Provider
  client_id	    = var.client_id
  client_secret   = var.client_secret
  admin_username = var.uname
  admin_password = var.upassword
}

module "bigip" {
  source = "./bigip"
  #variables for basic bigip setup
  location = module.vnet.rg_location
  rg_name = module.vnet.rg_name
  prefix = "${var.prefix}-bigipvm"
  #variables for networking
  mgmt_subnet_id = module.vnet.mgmt_subnet_id
  internal_subnet_id = module.vnet.internal_subnet_id
  external_subnet_id = module.vnet.external_subnet_id
  mgmt_gw    = cidrhost(module.vnet.mgmt_subnet_prefix, 1)
  ext_gw     = cidrhost(module.vnet.external_subnet_prefix, 1)
  int_gw     = cidrhost(module.vnet.internal_subnet_prefix, 1)
  f5vm01mgmt = cidrhost(module.vnet.mgmt_subnet_prefix, 4)
  f5vm02mgmt = cidrhost(module.vnet.mgmt_subnet_prefix, 5)
  f5vm01ext  = cidrhost(module.vnet.external_subnet_prefix, 10)
  f5vm01ext_sec = cidrhost(module.vnet.external_subnet_prefix, 100)
  f5vm02ext  = cidrhost(module.vnet.external_subnet_prefix, 11)
  f5vm02ext_sec = cidrhost(module.vnet.external_subnet_prefix, 101)
  f5vm01int  = cidrhost(module.vnet.internal_subnet_prefix, 10)
  f5vm02int  = cidrhost(module.vnet.internal_subnet_prefix, 11)
  #variables for onboard.tpl
  uname = var.uname
  upassword = var.upassword
}

resource "local_file" "kube_config" {
    content     = module.aks["cluster1"].kube_config_raw
    filename = "${path.module}/kube_config"
}
resource "local_file" "kube_config1" {
    content     = module.aks["cluster2"].kube_config_raw
    filename = "${path.module}/kube_config1"
}