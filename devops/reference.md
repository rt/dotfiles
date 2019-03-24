# Reference

## Hostname

*This is old Ubuntu < 18*
```bash
sudo vim /etc/hostname
```

## Network

*This is old Ubuntu < 18*
```bash
sudo vim /etc/network/interfaces
```

```bash
# Host-only network
auto enp0s8
iface enp0s8 inet static
address 192.168.99.20
netmask 255.255.255.0
network 192.168.99.0
broadcast 192.168.99.255
```



ifconfig -a
ip addr
ip route
