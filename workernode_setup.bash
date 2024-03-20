#!/bin/bash

# Select prefer editor
sudo update-alternatives --config editor 

sudo apt purge needrestart -y
sudo apt-get update
sudo apt install ansible -y

ansible-playbook workernode.yaml --syntax-check
ansible-playbook workernode.yaml  --ask-become-pass
