# dotfiles

Just my personal dotfiles, not that great.
Over the years this seems to be one of the only things I try to keep up.
As such, it's becoming more of a convenience place to help with productivity.
More heavy lifting stuff is done in the remira repo.

- bash_profile: individual topics to put in env
- bin: tranferred to home direrectory
- bin-tests: tests for bin
- config: config files for build
- dockerfiles: Dockerfiles for whatevers
- dotfiles: vim, tmux, scripts, etc.
- environment setup: mac, cloud instance, raspberrypi ...
- quick-reference: preview from vim/terminal things I quickly forget
- playground: for screwing around, testing, etc.
- qmk: my qmk keyboard files

### dotfiles

Things you might want to put in your shell profile.
It's a 'buy in' system where you make a `config` file that contains the files you want to include.

- bash_profile (env vars, aliases, functions)
- bin (executables)
- dotfiles (.vimrc, .tmux.conf, etc)

The bootstrap command will put the files in $HOME/.extrafile, which you can source in your shell initializer (.bash_profile, etc)
`todo`: should allow `config` to be anywhere

```bash
git clone https://github.com/rt/dotfiles.git
cd dotfiles/
./bootstrap configfile
echo "source ~/.extrafile" >>  ~/.bash_profile
source ~/.bash_profile
```

**aliases**
- command/<file>: set aliases for a command but also namespace alises with prefix of command for easier referencing
- utils: 'other' aliases to utils, functions, etc


### Environments

**Mac**

*Install Homebrew*
https://brew.sh/#install

```bash
# install dotfiles with config containing bash_profile/macos.bash
...
mac.install.tools
```

**CloudEnv**

**Non-docker solution**
```bash
# todo: linux.install.tools
```

**Docker**

It was thought to just have it all in a container but this abstraction can cause inconveniences too.
The devenv Dockerfile is in `dockerfiles/` ... 

**Raspberry pi**

todo: 


### qmk

I was having a hard time maintaining a fork of qmk_firmware without having conflicts (?)
It's easier to just have my keyboard files here and copy them to a qmk_firmware clone.

```bash
git clone https://github.com/qmk/qmk_firmware
cd dotfiles/
./copy_qmk_files ../qmk_firmware/
cd ../qmk_firmware/
make handwired/mrkabuda:ryan:avrdude
```

**Dependencies**
You won't be able to flash the first time, and there will be a warning.
```bash
./util/qmk_install.sh
make git-submodule
```

### Other installs

*flutter*
```bash
git clone https://github.com/flutter/flutter.git -b stable --depth 1
flutter doctor # after adding to path
```

*openscad*

*kicad*


### playground and quick reference

Mainly for my own lookup, lots to clean up atm...
The general feel is easy reference, repl selected statements, small tinkerings before making an actual project.
