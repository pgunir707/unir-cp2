variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

# Standard_D2_v2 = 2 CPU 7 GB - Master
# Standard_D1_v2 = 1 CPU 3.5 GB - Worker y NFS
variable "vm_size" {
  type = list(string)
  description = "Tamaño de la máquina virtual"
  default = ["Standard_D2_v2", "Standard_D1_v2", "Standard_D1_v2" ] 
}

variable "vm_names" {
  type = list(string)
  description = "Nombre de las máquinas"
  default = ["master", "worker01", "nfs"]
}
