
get_vim_bundles() {

  cd ~
  #put stuff in bin ... (didn't want to add assume another dir in home)
  mkdir bin

  cd ~/bin
  curl http://www.gnu.org/software/bash/manual/bash.txt > bash.txt

  #powerline fonts for tmux themes and vim-airline
  cd ~/bin
  git clone https://github.com/powerline/fonts.git
  cd ~/bin/fonts
  ./install.sh

  #optional tmux themes
  cd ~/bin
  git clone https://github.com/jimeh/tmux-themepack.git

  #osx base16 terminals
  cd ~/bin
  git clone https://github.com/korzhyk/base16-terminal-app.git

  cd ~/
}

