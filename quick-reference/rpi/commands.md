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


