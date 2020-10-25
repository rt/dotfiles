# Workshop

Provide a workshop where children can get a fun introduction to computers, software, and electrical circuits.

## Making Images for all the students 

The current images is on Google Drive of pebblefields.com (takes a long time to
download), or on the Windows10 machine

```
sudo diskutil unmountDisk /dev/diskN
sudo dd if=~/rpi-workshop.img of=/dev/rdiskN bs=1m
```

For each sd card, boot and change to correct student name
```
sudo vim /etc/hostname
sudo vim /etc/hosts
```

Probably should boot all of them to the workshop network to make sure they work.


## Ideas notes to improve on the next build

*Ideas*

*Pre-boot*

*Post-boot*

add C wiringpi and one reference if people want to dev in C

dev env stuff?
```
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
```




## Todo


1. Process

a. createImage(student) x 10 students
b. boot all raspberry pies and check web server running and tmux installed

2. Brochure &  Receipts


## Environment

### Network Requirements

The RPi will be ssh enabled over microUSB and hostname=[student's name].  This
will allow you connect without a network.  It will also have DHCP enabled by
default to connect to my WiFi router.  This will allow me to connect easily
during class to help out.  You can change the network by doing the following.

- Connect to RPi via microUSB
- ssh pi@students_name.local
- nano ....
- reboot


Any of the following environments will allow you to participate.

1. Macbook or Linux with a USB port

2. Windows 10 with ssh or putty installed with a USB port

To power the Raspberry Pi please bring any of the following
- microUsb power adapter
- portable battery
- it also can be powered by your laptop (via the usb port)


## Things to bring in just in case

- usb power hub
- computers
- microUSB card reader, in case you need to re-image
- wifi (have everyone connect to wifi first, if someone can't they can use microUSB)
- soldering iron
- extra components, etc


## Notes

I could just buy the following

- Provide the power:

They can hook up to their computers but if it doesn't work, have these handy
10 power adapters and an extension cords (10 x $10)

https://www.amazon.com/Yuconn-Switch-Charger-Adapter-Raspberry/dp/B071YC2T9S/ref=sr_1_10?s=electronics&ie=UTF8&qid=1523583517&sr=1-10&keywords=micro+usb+charger+raspberry+pi


usb hub with cables

https://www.amazon.com/Sabrent-Family-Sized-Charger-Technology-AX-TPCS/dp/B00OJ79UK6/ref=sr_1_5?s=electronics&ie=UTF8&qid=1523583306&sr=1-5&keywords=usb+power+strip&dpID=51epqEGhcKL&preST=_SY300_QL70_&dpSrc=srch



## Investment Cost for 10

- Rpi Zero $12 x 10            = $120
- MicroSD Cards 10 pack (8GB)  = $60
- Case $12 x 10                = $120
- Header Pins $10(10pcs) x 2   = $20
- Solder                       = $7
- Seven Segments $8(10pcs) x 2 = $16
- LED Lights 300pcs x 1        = $10
- Shift Register $7(4pcs) x 5  = $35
- Resistors ... 50pcs(kit) x 1 = $12
- Jump Wires
  Total                        = $400+

Or, buy this kit and divide up (50 LED, 40 resistors, etc) $17
https://www.amazon.com/gp/product/B073ZC68QG/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1

Shift Register
https://www.amazon.com/Instruments-74HC595-SN74HC595N-Registers-3-State/dp/B011NA30RK/ref=sr_1_5?ie=UTF8&qid=1523584678&sr=8-5&keywords=shift+register&dpID=41BisKzWs5L&preST=_SY300_QL70_&dpSrc=srch




## Possible Avenues

Iolani After School
ex.  Creative Coding: Scratch (3 - 6th graders)
- Jan 9 - May 22 (3 months)  .... like 14 sessions
- 1/week 1.5 hrs 2:30 - 4
- $400 - $540  


Iolani Summer Session
ex.  What's App!  (5 - 8th graders)
- 3 weeks 2 hours/day ... like 15 session 
- 8 - 10am ... 1:15 - 3:15pm  (8 - 10 might be better for work)
- $335
- can do "Tuition includes Raspberry Pi kit"


Sacred Hearts Academy Summer School
ex. C++ Programming (9 - 12th graders)
- Jun 11 - July 13
- 8 - 10am
- $450
