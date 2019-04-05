# VirtualBox

Create VMs on Host Network
- master 192.168.99.20
- node1 192.168.99.21
- node2 192.168.99.22

```bash
brew cask install virtualbox
vboxmanage --version

#vboxmanage setproperty machinefolder /app_store/virtual_machines
```

## Create Host Network

*Network Manager*
- :setup a host network (vboxnet0)
- 192.168.99.1 255.255.255.0 disable dhcp

## Create Default Node

- create VM all defaluts
- add adapter for host network(vboxnet0)
- download ubuntu server image 
- attach as optical device in Storage Settings
- start the machine and install ubuntu w/defaults (no packages or anything) username/password
- should see 2 network adapters (nat/dhcp, host network)

*Install common apps*

If doing manually, might be easier setting up the network first so that you can ssh 

```bash
sudo -s
```

```bash
sudo apt update
sudo apt install openssh-server
sudo apt install docker.io

# reboot?
sudo systemctl enable docker

```

## Clone Machines
// clone machines (master: 2cpu, 2G mem, slave: 1cpu, 1G mem)

## config each node

```bash
sudo hostnamectl set-hostname <nodename>

# if hostname in /etc/hosts
sudo vim /etc/hosts

# change preserve_hostname: true
sudo vim /etc/cloud/cloud.cfg

# verify after reboot
hostnamectl
```

```bash
sudo vim /etc/netplan/xxx.yaml
```

```bash
network:
      version: 2
      renderer: networkd
      ethernets:
        enp0s3:
          dhcp4: yes
        enp0s8:
          dhcp4: no
          addresses: [192.168.99.20/24]
          routes:
          - to: 192.168.99.1/24
            via: 192.168.99.1
            metric: 100
```

```bash
sudo netplan apply
```


```bash
sudo service docker start
```



