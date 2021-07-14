# Creamos una máquina virtual

resource "azurerm_linux_virtual_machine" "vm_template" {

    count               = length(var.vm_names)
    name                = "${var.vm_names[count.index]}"
    resource_group_name = azurerm_resource_group.rg.name
    admin_username      = "pedro"
    location            = azurerm_resource_group.rg.location
    size                = "${var.vm_size[count.index]}"
    network_interface_ids = [ azurerm_network_interface.az_vm_nic[count.index].id ]
    disable_password_authentication = true
    computer_name = "${var.vm_names[count.index]}"

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}
