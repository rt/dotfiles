# Ryan's ergodox

This is a copy from ergodox_infinity/dudeofawesome without the lighting stuff

Download the executable and do as in the local docs.

https://www.pjrc.com/teensy/loader_cli.html

~/Downloads/teensy_loader_cli -mmcu=atmega32u4 -w qmk_firmware/ergodox_ez_default.hex

or better, copy `teensy_loader_cli` to ~/bin/ and just run the following

```
make ergodox_ez:ryan:teensy
```
