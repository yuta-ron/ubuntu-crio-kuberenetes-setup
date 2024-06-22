# Summary
<img src="https://github.com/yuta-ron/ubuntu-crio-kuberenetes-setup/assets/18624396/a13caa53-b843-4fc2-84fb-316995c285b8" width="320px">

I'm trying to build a k8s cluster using a Raspberry Pi, both for my own training and to satisfy my curiosity.
This repository also purpose as a note to myself.

The following list is host information.

| Host                   | OS             | Memory | k8s ver | CRI-O ver | 
| ---------------------- | -------------- | ------ | ------- | --------- | 
| Raspberry Pi 4 ModelB  | Ubuntu 22.04.4 | 8GB    | 1.29.2  | 1.24      | 
|                        |                |        |         |           | 

# Setup

### Kubernetes

controlplane
```bash
git clone git@github.com:yuta-ron/ubuntu-crio-kuberenetes-setup.git
cd ubuntu-crio-kubernetes-setup

./controlplane_setup.bash

# Execute following command at controlplane.
# Specify IP Address of controlplane. 
# (Failures when specify other address)
ip_address=$(hostname -I | awk '{print $1}')
sudo kubeadm init --cri-socket=/var/run/crio/crio.sock --pod-network-cidr=10.85.0.0/16 --control-plane-endpoint="$ip_address" --kubernetes-version 1.30.2

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

workernode
```
./workernode_setup.bash

# Execute following command at workernode
# Specify IP Address of controlplane.
# "hostname.local" is not acceptable.
# sudo kubeadm join 192.168.0.1:6443 --certificate-key xxxxxx ...

```

### Monitoring (Prometheus, Grafana)
```
# SetUp
./monitoring_setup.bash

# Retrieve Password
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# Delete
./monitoring_delete.bash
```

# Appendix 
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

