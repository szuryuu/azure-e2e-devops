output "vm_nic" {
  value = [azurerm_network_interface.vm_nic]
}

output "vm_pub_ip" {
  value = azurerm_public_ip.vm_pub_ip.ip_address
}

output "vm_vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vm_vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

