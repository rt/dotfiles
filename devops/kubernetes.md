# Kubernetes

Nodes: VMs (192.168.99.20–22)
Pods: CIDR 192.168.0.0/16

## Master

### Install kubeadm
```bash
sudo swapoff -a
sudo snap install kubeadm --classic
sudo snap install kubelet --classic
sudo snap install kubectl --classic
```
// restart and configure node
comment out any swap in `/etc/fstab`



### Choose CNI plugin (Calico)

```bash
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
sudo kubeadm init --api-server-advertise-address=192.168.99.20 --pod-network-cidr=192.168.0.0/16
```

This will give you a join token you need to remember 

## Nodes

Install kubeadm

```bash
kube join ...
```




```bash
kubectl get nodes
```
