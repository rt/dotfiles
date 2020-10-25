# dotfiles

Just my personal dotfiles, not that great.

Things you might want to put in your shell profile.
It's a 'buy in' system where you make a `config` file that contains the files you want to include.

- bash_profile (env vars, aliases, functions)
- bin (executables)
- dotfiles (.vimrc, .tmux.conf, etc)

**aliases**

- command/<file>: set aliases for a command but also namespace alises with prefix of command for easier referencing
- utils: 'other' aliases to utils, functions, etc

The following command will put the files in $HOME/.extrafile, which you can source in your shell initializer (.bash_profile, etc)
todo: should allow `config` to be anywhere

### Mac DevEnv

*Install Homebrew*
https://brew.sh/#install

```bash
git clone https://github.com/rt/dotfiles.git
cd dotfiles/
./bootstrap configfile
echo "source ~/.extrafile" >>  ~/.bash_profile
source ~/.bash_profile
mac.install.tools
```

### CloudEnv

**Non-docker solution**
```bash
# todo: linux.install.tools
```


### Other

*qmk*

Check out the dependencies here

https://github.com/qmk/qmk_toolbox

```bash
brew tap osx-cross/avr
brew tap PX4/homebrew-px4
brew install avr-gcc
brew install dfu-programmer
brew install gcc-arm-none-eabi
brew install avrdude
brew install teensy_loader_cli
```

*flutter*
```bash
git clone https://github.com/flutter/flutter.git -b stable --depth 1
flutter doctor # after adding to path
```

*openscad*

*kicad*
