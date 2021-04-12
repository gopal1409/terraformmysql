    resource "azurerm_virtual_machine" "demo-instance" {
    name = "${var.prefix}-vm"
    location = var.location
    resource_group_name = azurerm_resource_group.demo.name 
    network_interface_ids = ["${azurerm_network_interface.demo-instance.id}"]
    vm_size = "Standard_B1S"
    # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

    storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"  
    }
    
  storage_os_disk {
    name              = "gopal-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
   os_profile {
    computer_name = "demo-instance"
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
resource "azure_rm_network_security_group_association" "demo-sg" {
  subnet_id = azurerm_subnet.demo-internal-1.id
  network_security_group_id =  azurerm_network_security_group.allow-ssh.id
}