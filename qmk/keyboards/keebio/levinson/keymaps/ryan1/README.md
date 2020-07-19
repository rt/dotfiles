# Levinson

I use this as a macro board (two).

I didn't want to use user space (ryan) so I renamed the directory ryan1
which allows me to have local macros

In order to flash each side you need to change `MASTER_RIGHT/LEFT` in config.h


```bash
make keebio/levinson/rev2:ryan1:avrdude
```

### Macro Ideas

Things that you don't need that much (beyond a certain point) and don't want to pollute more layers.

- Vim cwd
- Volume
- Zoom

One time after flashing the keyboard didn't respond.  I needed to erase the EEPROM to solve this.
Enable bootmagic in `rules.mk`.

https://docs.qmk.fm/#/feature_bootmagic
