#!/bin/bash

# Select prefer editor
sudo update-alternatives --config editor 

sudo apt purge needrestart -y
sudo apt install ansible helm -y

ansible-playbook controlplane.yaml --syntax-check
ansible-playbook controlplane.yaml --ask-become-pass
