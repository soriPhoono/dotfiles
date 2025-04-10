#!/usr/bin/env bash

hostname=$(hostnamectl | grep "Static hostname" | awk '{print $3}')

echo "Dotfiles -- Sori Phoono"

sudo pacman -Sy --noconfirm --needed direnv git

echo "----------------------------------------"
echo "Creating virtual environment..."

direnv allow

echo "----------------------------------------"
echo "Installing Ansible..."

pip install -r requirements.txt

echo "----------------------------------------"
echo "Running Ansible playbook..."
ansible-playbook -Ji ansible/inventory.yml "ansible/$hostname.yml"
