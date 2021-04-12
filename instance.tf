    resource "azurerm_virtual_machine" "demo-instance" {
    name = "${var.prefix}-vm"
    location = var.location
    resource_group_name = azurerm_resource_group.demo.name 
    network_interface_ids = ["${azurerm_network_interface.demo-instance.id}"]
     vm_size = "Standard_B1S"
    delete_os_disk_on_termination = true  
    delete_data_disk_on_termination = true

    storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"  
    }
    
  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  #we are adding addtional storage of 10GB
  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }
  os_profile {
    computer_name_prefix = "demo-instance"
    admin_username = "demo"
    admin_password = "Admin@123456"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}  

resource "azurerm_network_interface" "demo-instance" {
    name = "${var.prefix}-instance1"
    location = var.location
    resource_group_name = azurerm_resource_group.demo.name 
    network_security_group_id = azurerm_network_security_group.allow-ssh.id
  ip_configuration {
    name = "instance1"
    subnet_id = azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.demo-instance.id
  }
}
resource "azurerm_public_ip" "demo-instance" {
 name = "instance-public-ip"
 location = var.location
 resource_group_name = azurerm_resource_group.demo.name 
 allocation_method = "Dynamic" 
}
