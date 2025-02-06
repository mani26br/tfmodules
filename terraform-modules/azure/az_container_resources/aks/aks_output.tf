output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_private_fqdn" {
  value = azurerm_kubernetes_cluster.aks.private_fqdn
}

output "aks_kube_admin_config" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config
}

output "aks_kube_admin_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}

output "aks_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config
}

output "aks_kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "aks_node_resource_group" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "aks_addon_profile" {
  value = azurerm_kubernetes_cluster.aks.addon_profile
}

output "aks_identity" {
  value = azurerm_kubernetes_cluster.aks.identity
}

/*
output "aks_agw_identity" {
  value = azurerm_kubernetes_cluster.aks.ingress_application_gateway
}
*/