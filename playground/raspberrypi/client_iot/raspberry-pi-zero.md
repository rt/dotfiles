
### Raspberry Pi Zero W Setup

Get raspbian  https://www.raspberrypi.org/downloads/raspbian/

**Flash**

*Should now have the image mounted on /Volumes/boot* 

3. Enable ssh
For headless setup, SSH can be enabled by placing a file named 'ssh', without any extension, onto the boot partition of the SD card. When the Pi boots, it looks for the 'ssh' file; if it is found, SSH is enabled and then the file is deleted. The content of the file doesn't matter: it could contain either text or nothing at all.
```
df -h
touch /Volumes/boot/ssh                 #enable ssh by creating the file
```

4. Get network via usb (Optional, because you can get network directly with wpa_supplicant.conf)
(This is only available for Zero)

Add the following line to /Volumes/boot/config.txt

```
dtoverlay=dwc2
```

In the file `cmdline.txt` insert `modules-load=dwc2,g_ether` after `rootwait`

5. Put card in RPI and connect power via the USB microUSB (not the power USB).
   Wait a minute, you should be able to ssh into RPI
   (pi@raspberrypi.local/raspberry)


6. Change hostname
Change the hostname in 
/etc/hosts
/etc/hostname

7. Reduce the GPU for headless usage (/boot/config.txt)
Add
```
gpu_mem=16 
```


8. Setup Wifi

http://weworkweplay.com/play/automatically-connect-a-raspberry-pi-to-a-wifi-network/

https://kerneldriver.wordpress.com/2012/10/21/configuring-wpa2-using-wpa_supplicant-on-the-raspberry-pi/

Maybe this is correct (/etc/dhcpcd.conf)
https://www.modmypi.com/blog/how-to-give-your-raspberry-pi-a-static-ip-address-update

```
interface eth0

static ip_address=192.168.0.10/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1

interface wlan0

static ip_address=192.168.0.200/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```

*DHCP*

make first line `auto wlan0` to /etc/network/interfaces

at the bottom of the file add these (tell pi to use the wpa_supplicant.conf file and allow wlan)
```
allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp
```


add the following to /etc/wpa_supplicant/wpa_supplicant.conf
```
network={
ssid="YOUR_NETWORK_NAME"
psk="YOUR_NETWORK_PASSWORD"
proto=RSN
key_mgmt=WPA-PSK
pairwise=CCMP
auth_alg=OPEN
}
```

*Static*

/etc/network/interfaces
Change `iface wlan0 inet dhcp` into `iface wlan0 inet static`

Add the following before the `wpa-conf` line
```
address 192.168.86.220 # Static IP you want 
netmask 255.255.255.0 
gateway 192.168.86.1   # IP of your router
```

once you have a static ip, you should ssh via the ip address (you dont need the usb connection)
reboot

### Docker

There is a utility script
```
curl -sSL https://get.docker.com | sh
```

Let user account access the docker client (after this you need to login/logout of pi)
```
sudo usermod pi -aG docker

docker run -p 3000:3000 pebble/skeleton-rasp
```

#### set docker to auto start (?)
```
sudo systemctl enable docker
```
Now, can start with 
```
sudo systemctl start docker
```

#### Using GPIO from docker
need `--privileged`

https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/

9. Add other things to the image

```
sudo apt-get install tmux vim
```

#### Docker Swarm

https://howchoo.com/g/njy4zdm3mwy/how-to-run-a-raspberry-pi-cluster-with-docker-swarm
http://tarunlalwani.com/post/deploy-selenium-grid-using-docker-swarm-aws/

https://github.com/ManoMarks/docker-swarm-visualizer

1. Choose a master advertise its address (it will return the join command)
```
docker swarm init --advertise-addr 192.168.1.181
```

2. Join from the nodes
```
docker swarm join --token SWMTKN-1-5rm2sib935txv5k13j6leaqsfuuttalktt7jv4s55249izjf54-8ia31tagc4sbehqeqiqst4jfz 172.30.0.170:2377
```

3. Create a service
```
docker service create \
--name viz \
--publish 8080:8080/tcp \
--constraint node.role==manager \
--mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
alexellis2/visualizer-arm:latest
```

4. Or, Deploy a stack with a compose file
```
docker stack deploy --compose-file docker-compose.yaml selenium
```

5. Scale
Master
```
docker info
docker service ls
docker service scale grid_chrome=4
```

#### Start Something on boot

/etc/rc.local

https://thepihut.com/blogs/raspberry-pi-tutorials/34708676-starting-something-on-boot


#### Clone Image

You can clone the image for the other nodes

**Clone SDCard Image**

Restore to multiple nodes, for each node

**Flash to multiple node**

Change ip address in `/etc/network/interfaces`


Change hostname in `/etc/hosts` and `/etc/hostname`




