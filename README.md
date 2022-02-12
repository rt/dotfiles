# dotfiles

personal dotfiles.

- bin: tranferred to home direrectory
- bin-tests: tests for bin
- config: config files for build
- dotfiles: vim, tmux, scripts, etc.
- setup: tmux sessions

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

