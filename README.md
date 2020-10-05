# dotfiles


## Mac DevEnv

*.bash_profile*

```bash
touch ~/.bash_profile
touch ~/.bashrc
```

*Install Homebrew*

https://brew.sh/#install


```bash
brew update && brew tap caskroom/cask
brew install coreutils
brew install wget
brew install nmap
brew install ngrep
brew install git
brew install tmux
brew install vim
brew install tree
brew install the_silver_searcher 
brew install ripgrep

brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew install shUnit2
brew install grip
brew install jq
# highlighting in vim fzf preview: need to do this manually if you want the latest hightlighting
#sudo easy_install Pygments
brew install highlight
brew install pandoc
brew install reattach-to-user-namespace
```

```bash
brew cask install caskroom/versions/java8
brew install gradle
brew install maven
brew install postgresql@9.4 
brew pin postgresql@9.4
brew cask install intellij-idea-ce
#brew cask install intellij-idea
brew cask install docker
brew cask install virtualbox
brew cleanup
```

*Node*
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
source ~/.bashrc
nvm use
```

*keyboard / arduino*

Check out the dependencies here

https://github.com/qmk/qmk_toolbox

```
brew tap osx-cross/avr
brew tap PX4/homebrew-px4
brew install avr-gcc
brew install dfu-programmer
brew install gcc-arm-none-eabi
brew install avrdude
brew install teensy_loader_cli
```

*dmg installs*

https://www.vagrantup.com/downloads.html

*flutter*
```bash
git clone https://github.com/flutter/flutter.git -b stable --depth 1
flutter doctor # after adding to path
```

*projects*

add `source ~/.extrafile` to `.bash_profile`

```bash
mkdir projects
git clone https://github.com/rt/dotfiles.git
cd dotfiles/
./bootstrap rtsunoda
get_vim_bundles
```

*themes/fonts*
```bash
cd ~/projects
#powerline fonts for tmux themes and vim-airline
git clone https://github.com/powerline/fonts.git
cd fonts/
./install.sh

#optional tmux themes
cd ~/projects
git clone https://github.com/jimeh/tmux-themepack.git

#osx base16 terminals
cd ~/projects
git clone https://github.com/korzhyk/base16-terminal-app.git
```

