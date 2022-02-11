
## Set static ip

/etc/network/interfaces

	# The loopback network interface
	auto lo
	iface lo inet loopback

	# The primary network interface
	auto eth0
	# make it comment
	#iface eth0 inet dhcp
	# add these lines
	iface eth0 inet static
	address 10.0.1.30# define IP address
	network 10.0.1.0# define network address
	netmask 255.255.255.0# define subnet mask
	broadcast 10.0.1.255# define broadcast address
	gateway 10.0.1.1# define default gateway
	dns-nameservers 10.0.1.1# define name server

	
	$initctl restart networking


#### Disable IP6

	$echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf 
	$sysctl -p

