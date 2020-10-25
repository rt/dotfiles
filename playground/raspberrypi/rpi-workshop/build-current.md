
# Current Image Build

1. Flash Image

Get raspbian  https://www.raspberrypi.org/downloads/raspbian/

Plug in usb with micro sd

```
df -h    #for example, mine shows /dev/disk2s1
sudo diskutil unmountDisk /dev/diskNs1
sudo dd if=path_of_your_image.img of=/dev/rdiskN bs=1m
```

*Should now have the image mounted on /Volumes/boot* 

2.  Add Pre-boot stuff

*a. Enable ssh via USB (only for rpi zero)*

- Enable by a ssh file existing
```
touch /Volumes/boot/ssh              
```

*b. Setup Network*

This should have the `ssid` and `psk` for the network (wifi) these nodes will participate in

create file `/boot/wpa_supplicant.conf`
```
ctrl_interface=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="remira"
    psk="1942194219"
    key_mgmt=WPA-PSK
}
```

*c Reduce the GPU for headless usage*
Edit `/boot/config.txt`
```
gpu_mem=16 
```

*d Unmount and Remove*
```
sudo diskutil unmountDisk /dev/diskNs1
```

3. Add Post-boot stuff

*a. Boot and ssh in*
```
ssh pi@raspberrypi.local #pi/raspberry
```

*b. Bootstrap with dotfiles*
```
# full upgrade
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get update  #do again to get all the packages

# install tools
sudo apt-get -y install vim nano tmux git
sudo apt-get -y install python3-pip
sudo apt-get -y install python-smbus

# get dotfiles
git clone https://bitbucket.org/ryan_tsunoda/dotfiles.git
cd dotfiles
./bootstrap student
echo 'source ~/.extrafile' >> ~/.profile
cd ..
rm -rf dotfiles
source ~/.profile


# install node  (check architecture with "arch", ie. armv6l)
wget https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-armv6l.tar.gz
tar xvzf node-v8.11.1-linux-armv6l.tar.gz
cd node-v8.11.1-linux-armv6l/  
sudo cp -R * /usr/local/
cd ..
rm node-v8.11.1-linux-armv6l.tar.gz
rm -rf node-v8.11.1-linux-armv6l/

# required python libs
pip3 install websocket-client

# Enable I2C 
sudo raspi-config

git clone https://bitbucket.org/ryan_tsunoda/course-rpi.git
```


*c. Install docker*

This seems to change often refer to the official docs
```
# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi

#sudo systemctl enable docker  ... is this needed

# I needed to reboot for docker to start (not just log out)
sudo shutdown -r 0 


# good debug stuff
#systemctl start docker
#systemctl status docker.service


ssh pi@raspberrypi.local
```

docker-compose
```
sudo pip3 install docker-compose

```

*Build and Name Container*
Build restart option (if it goes down other than when intentionally stopped, it will restart) 

``` 
sudo docker run --name skeleton-rasp -p 80:3000 --restart unless-stopped pebble/skeleton-rasp 
```

*Setup to autostart with systemd*
https://toub.es/2017/08/08/how-to-start-a-docker-container-at-boot-time/

Create the service

```
sudo vim /lib/systemd/system/pebble.service
```

Contents
```
[Unit]
Description=Pebble Service
Requires=docker.service
After=docker.service

[Service]
#Restart=always
ExecStart=/usr/bin/docker start -a skeleton-rasp
ExecStop=/usr/bin/docker stop -t 2 skeleton-rasp

[Install]
WantedBy=default.target
```

Enable service on boot
```
sudo systemctl enable pebble.service
```

Check current status
```
sudo systemctl status pebble.service
```

- Change hostname to "student"
```
sudo vim /etc/hostname
sudo vim /etc/hosts
```

*Reboot and see if the service loaded at boot*
```
sudo shutdown -r 0
```
After a few minutes check in the browser http://student.local/

*Shutdown and remove card to clone*
```
sudo shutdown -h 0
```

3. Clone and store

You can clone the image for the other nodes
```
sudo dd if=/dev/rdiskN of=~/rpi-workshop.img bs=1m
```

Store this on Google Drive of pebblefields.com (too slow) and on the Windows10 machine



