# Iot #

## Common Tasks

*Flash*

Plug in usb with micro sd

```
df -h    #for example, mine shows /dev/disk2s1
sudo diskutil unmountDisk /dev/diskNs1
sudo dd if=path_of_your_image.img of=/dev/rdiskN bs=1m
```

*Wifi Setup on boot*

## Be able to SSH when it boots for headless mode

This needs to be available on boot to enable ssh (then it is removed)
```
touch /Volumens/boot/ssh
```

If a wpa_supplicant.conf file is placed into the /boot/ directory, this will be
moved to the /etc/wpa_supplicant/ directory the next time the system is booted,
overwriting the network settings; this allows a Wifi configuration to be
preloaded onto a card

This needs to be available on boot to enable ssh (then it is removed)
/boot/wpa_supplicant.conf
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

*More responsive mouse (gui environments)*

add to `/boot/cmdline.txt`

```
usbhid.mousepoll=0
```


*Clone SDCard image for backup*

```
sudo dd if=/dev/rdiskN of=~/rpi.img bs=1m
```


*Basic Tools*
```
sudo apt-get install tmux vim nano git python3 
sudo apt-get install python3-pip
sudo pip3 install virtualenv
```

### When to us RP vs Arduino

https://www.universalmind.com/blog/raspberry-pi-vs-arduino-when-to-use-which/

##### Raspberry Pi
- powerful
- full computer, full stack

##### Arduino
- no OS/file system, no SD card
- can be powered up/down anytime
- takes analog input by default

### Analog Inputs for RP

https://learn.adafruit.com/reading-a-analog-in-and-controlling-audio-volume-with-the-raspberry-pi/overview

### Projects

#### Docker Swarm Full Stack Skeleton (Educational)

Create multiple docker swarm managers and nodes showing HA for skeleton w/postgres.  

1. Show HA (app server, db)
2. Show Rolling Deployment

Note: Sub-systems need ARM based images.

### Raspberry Pi:  Usefull Commands
```
ssh pi@raspberrypi.local                    #default password is "raspberry"
sudo passwd pi                              #change password

sudo raspi-config

lsusb                                       #show attached devices

free -h                                     #check how much free memory there is
vcgencmd get_mem arm                        #show total mem
vcgencmd get_mem gpu                        #show total gpu mem
vcgencmd measure_temp 

cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/partitions
cat /proc/version

top                                         #cpu usages
df -h                                       #disk space
uptime                                      #average load


sudo shutdown –h now
startx

sudo raspi-config
```

## Sensors

Flag             | Description
-----------      | --------------------------------------------------
--Analog Hall    | Based on the Hall Effect, a Hall sensor is a one that varies its output voltage in response to a magnetic field.  Hall sensors are used for proximity switching, positioning, speed detection, and current sensing applications.
--Auto-flash LED | Auto flash build-in colors on power on
--Avoidance      |
--Barometer      | Mesures atmosperic pressure.  Used in forecasting weather and determining altitude
--Flame          | Flame Sensor can be used to detect fire source or other light sources of the wavelength in the range of 760nm - 1100 nm
--Laser Emit
--Linear Hall    | Depending on the magnetic field, the output does not have a discrete switching state, but provides a signal proportional to the magnetic field strength.
--Reed Switch    | The reed switch (sometimes also known as Herkon) is an electrical switch operated by an applied magnetic field
--Shock          |
--Buzzer         |
--Light Blocking |
--Relay          | A relay is an electromagnetic switch operated by a relatively small electric current that can turn on or off a much larger electric current.
--SMD RGB        |
--Sound          | Big vs Small ?
--Rotary Encoder | also called a shaft encoder, is an electro-mechanical device that converts the angular position or motion of a shaft or axle to an analog or digital signal
--Tap
--Temp           | Digital and Analog
--Touch          |
--Tracking       | A tracking sensor has the same principle with an obstacle avoidance sensor (reflection) but has small transmitting power.
--Water Level    |
