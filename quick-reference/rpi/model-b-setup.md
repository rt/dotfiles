# Model B Setup 

## Flash

Get it
https://retropie.org.uk/download/

**Flash**

## Be able to SSH when it boots for headless mode

**Setup Wifi on boot***

```
ssh pi@retropie.local
```

**Add for more responsive mouse**

## Setup 

### dotfiles, playground

Most of my setup stuff is for mac, will need to do it for raspbian
```
sudo apt-get install vim tmux 
sudo apt-get install silversearcher-ag

get_vim_bundles
```



## Retropie 

https://github.com/RetroPie/RetroPie-Setup/wiki

This is a good script to remember from ssh

*retropie setup*

```
sudo ~/RetroPie-Setup/retropie_setup.sh
```


### My gamepad configurations (you can reset using retropie_setup.sh)

d-pad up       : w
d-pad down     : s
d-pad left     : a
d-pad right    : d
start          : 9
select         : 8
A              : k
B              : l
X              : j
Y              : i
L shoulder     : e
R shoulder     : u
l trigger      : r
r trigger      : y
l thumb        : x
r thumb        : c
l analog up    : g
l analog down  : b
l analog left  : v
l analog right : n
r analog up    : '
r analog down  : ;
r analog left  : [
r analog right : ]
hotkey         : \


## Emulator

find different game roms and scp them in *~/RetroPie/roms/EMULATOR_NAME*

i think you just need to copy them in

### Starting and Stoping the desktop

```
sudo systemctl stop lightdm
emulationstation

... # play and have fun
Start will give you the menu, select quit, quit Emulationstation

sudo systemctl start lightdm
```

##### MAME 

https://github.com/retropie/retropie-setup/wiki/Arcade

Need to get the right romset games and put them in the correct emulator directory

MAME0.37b5 > mame-mame4all/

https://archive.org/details/MAME0.37b5_MAME2000_Reference_Set_Update_2_ROMs_Samples

MAME2003 > mame-libretro/

https://archive.org/details/MAME2003_Reference_Set_MAME0.78_ROMs_CHDs_Samples

http://docs.mamedev.org/usingmame/defaultkeys.html


## Install lxce Desktop

https://retropie.org.uk/docs/FAQ/#where-did-the-desktop-go

Configuration / Tools >> Raspbiantools >> Install Pixel Desktop Environment

or, manually
```
sudo apt-get install --no-install-recommends lxde
sudo apt-get install xorg raspberrypi-ui-mods rpi-chromium-mods
```

## Simple Libraries

### Install Basic Tools

**Basic Tools**

### WiringPi

this is the wiring lib like in Arduino (good for people who use Arduino)

```
# note you dont need this if you have the latest retropie
mkdir ~/projects
cd ~/projects/
git clone git://git.drogon.net/wiringPi
cd wiringPi
./build

gpio -v 
gpio readall
```

### RPi.GPIO (Python)

The Raspbian OS image has this installed by default

### Tight VncServer
```
sudo apt-get install tightvncserver
vncserver :1
```
password:12345678
not view-only password


```
tightvncserver
```

todo: Should Make autostart ...


### fswebcam
```
sudo apt-get install fswebcam
```


------- clone retro-lcde.img



## Open CV

```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo rpi-update
$ sudo reboot
```


*install dev tools*
```
sudo apt-get install build-essential git cmake pkg-config
```

*install image I/O packages*
```
sudo apt-get install libjpeg-dev 
sudo apt-get install libtiff5-dev 
sudo apt-get install libjasper-dev 

#(had unmet dependency problems!!! try this again later)  
sudo apt-get install libpng12-dev  
```

*install video I/O packages*
```
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
```

We need to install the GTK development library so we can compile the highgui
sub-module of OpenCV, which allows us to display images to our screen and build
simple GUI interfaces 

``` 
sudo apt-get install libgtk2.0-dev 
```

Various operations inside of OpenCV (such as matrix operations) can be
optimized using added dependencies:

```
sudo apt-get install libatlas-base-dev gfortran
```

install python 2.7 and Python 3 header files so we can compile our OpenCV + Python bindings

```
sudo apt-get install python2.7-dev python3-dev
```


```
cd ~/projects
git clone --depth 1 https://github.com/opencv/opencv
git clone --depth 1 https://github.com/opencv/opencv_contrib
```

*Build in virtualenv*


```
pip install numpy
```

```
cd ~/projects/opencv/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/projects/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON ..
```

```
make -j4
```
I had trouble, this might be safer

```
make clean
make
```

```
sudo make install
sudo ldconfig
```

For some reason it gets named wrong (or doesn't work with the name given)
If that is the case, rename it as below
```
cd /usr/local/lib/python3.5/site-packages/
sudo mv cv2.cpython-35m-arm-linux-gnueabihf.so cv2.so
```

For a git project "test"

```
mkdir test
cd test
virtualenv -p python3 venv
source venv/bin/activate
pip install numpy
cd venv/lib/python3.5/site-packages/
ln -s /usr/local/lib/python3.5/site-packages/cv2.so .
```


### Sunfounder Tutorials

```
git clone https://github.com/sunfounder/Sunfounder_SuperKit_C_code_for_RaspberryPi.git
git clone https://github.com/sunfounder/Sunfounder_SuperKit_Python_code_for_RaspberryPi.git
```


