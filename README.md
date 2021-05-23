# dotfiles

Just my personal dotfiles/playground, not that great.

- dockerfiles: Dockerfiles for whatevers
- keyboard: keyboard stuff
-- qmk: my qmk keyboard files
-- read-only-keymaps: quick reference keymaps
- playground: for screwing around, testing, etc.
- profile: individual topics to put in env
-- bin: tranferred to home direrectory
-- bin-tests: tests for bin
-- config: config files for build
-- dotfiles: vim, tmux, scripts, etc.
-- setup: mac, cloud instance, raspberrypi ...
- quick-reference: preview from vim/terminal things I quickly forget

### profile

Things you might want to put in your shell profile.
It's a 'buy in' system where you make a `config` file that contains the files you want to include.

- (env vars, aliases, functions)
- bin (executables)
- dotfiles (.vimrc, .tmux.conf, etc)

The bootstrap command will put the files in $HOME/.extrafile, which you can source in your shell initializer (.bash_profile, etc)
`todo`: should allow `config` to be anywhere

```bash
git clone https://github.com/rt/dotfiles.git
cd dotfiles/profile/
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
