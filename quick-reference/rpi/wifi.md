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


