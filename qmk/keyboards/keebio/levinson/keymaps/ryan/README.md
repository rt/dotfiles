Levinson
========

A split 40% split 4x12 ortholinear keyboard made and sold by Keebio. It's
essentially a Let's Split with LED backlight support and 2u thumb key support.
[More info at Keebio](https://keeb.io).

Keyboard Maintainer: [Bakingpy/nooges](https://github.com/nooges)  
Hardware Supported: Pro Micro  
Hardware Availability: [Keebio](https://keeb.io)  


Initially, you do need to have both sides flashed, as that allows both sides to
talk to each other using the same communication protocol

Once both sides are flashed, you only need to flash the master side if you are
just updating the keymap

Make example for this keyboard (after setting up your build environment):

```bash
make keebio/levinson/rev2:ryan
```

Example of flashing this keyboard:

```bash
make keebio/levinson/rev2:ryan:avrdude
```

When you do this it will ask you to reset the controller, I did so by shorting `GND` and `RST`.  

It says here https://docs.keeb.io/flashing-firmware/

> To place your microcontroller into DFU (Bootloader) Mode, you will need to
> short the BOOT0 or RESET or RST pins/holes to ground.





See [build environment setup](https://docs.qmk.fm/build_environment_setup.html) then the [make instructions](https://docs.qmk.fm/make_instructions.html) for more information.

A build guide for this keyboard can be found here: [Levinson Build Guide](https://docs.keeb.io)



## My parts

- Pro Micro - 5V/16MHz - Arduino-compatible ATmega32U4 
- 1N4148 Diodes

## Troubleshooting

One time after flashing the keyboard didn't respond.  I needed to erase the EEPROM to solve this.
Enable bootmagic in `rules.mk`.

https://docs.qmk.fm/#/feature_bootmagic
