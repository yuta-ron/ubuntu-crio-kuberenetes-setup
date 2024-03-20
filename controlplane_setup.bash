#!/bin/bash

# Select prefer editor
sudo update-alternatives --config editor 

sudo apt purge needrestart -y
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt install ansible helm -y

ansible-playbook controlplane.yaml --syntax-check
ansible-playbook controlplane.yaml --ask-become-pass
