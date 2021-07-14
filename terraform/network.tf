# Creación de red
resource "azurerm_virtual_network" "az_vm_net" {
  name                = "kubernetesnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    environment = "CP2"
  }
}

# Creación de subnet
resource "azurerm_subnet" "az_vm_subnet" {
  name                 = "terraformsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.az_vm_net.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create NIC
resource "azurerm_network_interface" "az_vm_nic" {
  count               = length(var.vm_names)  
  name                = "vm_nic_${var.vm_names[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfiguration_${var.vm_names[count.index]}"
    subnet_id                     = azurerm_subnet.az_vm_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.${count.index + 10}"
    public_ip_address_id          = azurerm_public_ip.az_vm_publicip[count.index].id
  }

  tags = {
    environment = "CP2"
  }
}

#IP pública
resource "azurerm_public_ip" "az_vm_publicip" {
  count               = length(var.vm_names)
  name                = "vm_ip_${var.vm_names[count.index]}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = {
    environment = "CP2"
  }
}
