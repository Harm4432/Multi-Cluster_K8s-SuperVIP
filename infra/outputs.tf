#AKS outputs
#output "client_certificate" { value = module.aks.client_certificate}
output "kube_config" {  
    value = module.aks["cluster1"].kube_config
    sensitive = true
    }
output "kube_config_raw" {  
    value = module.aks["cluster1"].kube_config
    sensitive = true
    }
output "kube_config1" {  
    value = module.aks["cluster2"].kube_config
    sensitive = true
    }
output "kube_config_raw1" {  
    value = module.aks["cluster2"].kube_config
    sensitive = true
    }

#BIGIP outputs
output "vm01mgmtpip" {  value = module.bigip.vm01mgmtpip}
output "vm02mgmtpip" {  value = module.bigip.vm02mgmtpip}

#Verification outputs

output "appUrl" {  value = "http://${module.bigip.lbpip}/" }
output "appUrl_secure" {  value = "https://${module.bigip.lbpip}/" }