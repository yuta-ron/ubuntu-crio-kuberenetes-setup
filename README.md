# Outline

I am trying to build a k8s cluster using a Raspberry Pi, both for my own training and to satisfy my curiosity.
This repository also purpose as a note to myself.

The following list is host information.

| Host                   | OS             | Memory | k8s ver | CRI-O ver | 
| ---------------------- | -------------- | ------ | ------- | --------- | 
| Raspberry Pi 4 ModelB  | Ubuntu 22.04.4 | 8GB    | 1.29.2  | 1.24      | 
|                        |                |        |         |           | 

Please run following commands before run ansible.

```bash
sudo update-alternatives --config editor 
# Select prefer editor

sudo apt purge needrestart -y
sudo apt install ansible -y

ansible-playbook setup.yaml --syntax-check
ansible-playbook setup.yaml --ask-become-pass

# If want to set up as controlplane.
# sudo kubeadm init --cri-socket=‘’/var/run/crio/crio.sock --pod-network-cidr=10.1.0.0/16 --control-plane-endpoint=(host_name).local --kubernetes-version 1.29.2
```

# memo 
crio.conf was slightly modified.

```diff
[crio.network]

# The default CNI network name to be selected. If not set or "", then
# CRI-O will pick-up the first one found in network_dir.
# cni_default_network = ""

# Path to the directory where CNI configuration files are located.
+ network_dir = "/etc/cni/net.d/"

# Paths to directories where CNI plugin binaries are located.
plugin_dirs = [
	"/opt/cni/bin/",
+	"/usr/lib/cni/",
]
```
