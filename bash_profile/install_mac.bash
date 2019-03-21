
# Get Homebrew, Homebrew Cask
install_mac() {
  brew install fzf
  brew install git
  brew install nmap
  brew install tmux
  brew install tree
  brew install vim
  brew install grip
  # brew install ctags
  brew tap universal-ctags/universal-ctags
  brew install --HEAD universal-ctags
  brew install the_silver_searcher #there are other fast grep like tools (ripgrep)
  brew install wget
  brew install pandoc
  brew install jq
  brew install ngrep
  brew install shUnit2
  brew install pgcli
  brew install gradle
  brew install ripgrep

  brew install teensy_loader_cli

  # highlighting in vim fzf preview: need to do this manually if you want the latest hightlighting
  #sudo easy_install Pygments
  brew install highlight

  gem install cani

}

