# Keeping up-to-date with qmk_firmware

I was having trouble maintaining my own fork and pulling from master so keeping the files here.

### Cloning for the first time

```
git clone https://github.com/qmk/qmk_firmware.git (or stash/pull)
util/qmk_install.sh
make git-submodule

cd ../dotfiles
./copy_qmk_files path/to/qmk_firmware
```

## Flashing

Check out the dependencies here

https://github.com/qmk/qmk_toolbox

```
brew tap osx-cross/avr
brew tap PX4/homebrew-px4
brew install avr-gcc
brew install dfu-programmer
brew install gcc-arm-none-eabi
brew install avrdude
```

### qmk_toolbox

You can us the visual tool (I ended up NOT using this, just do what is in the README of the keyboard)

https://github.com/qmk/qmk_toolbox/releases


## My Keyboards

### Dactyl Manuform
- white board
- 3d print (reverse thumb)
- dactyl

### Minidox
- acrylic plate
- steel plate

### ErgoTravel
This is to let people try out split boards ...

### crkbrd
This is the travel board

### Ryan Switch Tester (keyboards/handwired/ryan_switch_tester/

### Mr Kabuda (keyboards/handwired/mrkabuda/
All custom boards that can be done with one controller

### Levinson

### Ergodox-ez

Download the executable and do as in the local docs.

https://www.pjrc.com/teensy/loader_cli.html

~/Downloads/teensy_loader_cli -mmcu=atmega32u4 -w qmk_firmware/ergodox_ez_default.hex

or better, copy `teensy_loader_cli` to ~/bin/ and just run the following

```
make ergodox_ez:ryan:teensy
```

## Swapping micro controllers

Sometimes its handy to grab a pro micro from another board, but sometimes it doesn't seem to register.
I find that first flashing the pro micro being moved to the board being moved to first, by itself does the trick.
Then flash the board again connected.


## Switch Tester

I used the handwired/dactyl_manuform/6x6 and https://github.com/ogatatsu/Cherry-Mx-Bitboard-Re socketed single switches.
To print them, use KiCad, clone the repo, go into the pitch that you want (18.5, 19.05, 19) select the *.kicad_pcb file
and create gerber files to send to allpcb.com.  In the order form I just took all the defaults.

## Notes

```
enum custom_keycodes {
  MY_MACRO = SAFE_RANGE
};

//...

case MY_MACRO: {
  if (record->event.pressed) {
    key_timer = timer_read();
    register_mods(MOD_BIT(KC_LCTL));
  }
  else if (timer_elapsed(key_timer) < TAPPING_TERM) {
    unregister_mods(MOD_BIT(KC_LCTL));
    register_mods(MOD_BIT(KC_LSFT));
    register_code(KC_EQL);
    unregister_code(KC_EQL);
    unregister_mods(MOD_BIT(KC_LSFT));
  }
  else {
    unregister_mods(MOD_BIT(KC_LCTL));
  }
  return false;
}

//...
```


```
#define IGNORE_MOD_TAP_INTERRUPT
#define TAPPING_FORCE_HOLD
```

