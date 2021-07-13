#!/bin/bash

echo "Lanzando playbook de prerrequisitos"
ansible-playbook -i hosts prerrequisitos.yaml

echo "Lanzando playbook para instalar docker y kubernetes"
ansible-playbook -i hosts -l master,worker k8s-init.yaml

echo "Lanzando playbook para montar el NFS Server"
ansible-playbook -i hosts -l nfs nfs.yaml

echo "Lanzando playbook para configurar el nodo master"
ansible-playbook -i hosts -l master k8s-master.yaml

echo "Lanzando playbook para instalar calico"
ansible-playbook -i hosts -l master k8s-sdn.yaml

echo "Lanzando playbook para configurar los workers"
ansible-playbook -i hosts -l worker k8s-worker.yaml

echo "Lanzando playbook para configurar HaProxy"
ansible-playbook -i hosts -l master k8s-haproxy.yaml
