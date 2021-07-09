#!/bin/bash

echo "Lanzando playbook de prerrequisitos"
ansible-playbook -i hosts playbooks/prerrequisitos.yaml
