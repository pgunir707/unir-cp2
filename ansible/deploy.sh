#!/bin/bash

echo "Lanzando playbook de prerrequisitos"
ansible-playbook -i hosts playbooks/prerrequisitos.yaml

echo "Lanzando playbook para instalar docker y kubernetes"
ansible-playbook -i hosts -l master,worker k8s.yaml

echo "Lanzando playbook para montar el NFS Server"
ansible-playbook -i hosts -l nfs nfs.yaml
