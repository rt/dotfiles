*Flash*

Plug in usb with micro sd

```
df -h    #for example, mine shows /dev/disk2s1
sudo diskutil unmountDisk /dev/diskNs1
sudo dd if=path_of_your_image.img of=/dev/rdiskN bs=1m
```

*Clone SDCard image for backup*

```
sudo dd if=/dev/rdiskN of=~/rpi.img bs=1m
```


