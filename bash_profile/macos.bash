alias mac.install.tools="install_mac_tools"
alias mac.cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias mac.afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias mac.emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# https://www.tekrevue.com/tip/rebuild-launchservices-fix-duplicate-entries-os-xs-open-menu/
# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias mac.lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias mac.hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias mac.showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Show/hide hidden files in Finder
alias mac.show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias mac.hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"
# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# requires brew first
install_mac_tools() {
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

  brew install go

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
  brew install reattach-to-user-namespace #needed by tmux 

  brew cask install caskroom/versions/java8
  brew install gradle
  brew install maven
  brew install postgresql@9.4 
  brew pin postgresql@9.4
  brew install clojure/tools/clojure
  brew cask install intellij-idea-ce
  #brew cask install intellij-idea
  brew cask install docker
  brew cask install virtualbox
  brew cask install openscad
  brew cask install kicad
  brew cleanup

  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
  source ~/.bashrc
  nvm use

  # https://github.com/clj-kondo/clj-kondo
  curl -sLO https://raw.githubusercontent.com/clj-kondo/clj-kondo/master/script/install-clj-kondo
  chmod +x install-clj-kondo
  ./install-clj-kondo

  clj-kondo --parallel --lint "$(lein classpath)"


  # brew install borkdude/brew/clj-kondo

  # themes/fonts
  cd ~/projects
  #powerline fonts for tmux themes and vim-airline
  git clone https://github.com/powerline/fonts.git
  cd fonts/
  ./install.sh

  # lein install
  ~/bin/lein

  #optional tmux themes
  cd ~/projects
  git clone https://github.com/jimeh/tmux-themepack.git

  #osx base16 terminals
  cd ~/projects
  git clone https://github.com/korzhyk/base16-terminal-app.git
}

