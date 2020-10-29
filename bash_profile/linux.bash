alias linux.install.tools="install_linux_tools"

# very similar to dockerfiles/devenv
install_linux_tools() {
  sudo apt-get update && \
  sudo apt-get install -y coreutils && \
  sudo apt-get install -y iputils-ping && \
  sudo apt-get install -y wget && \
  sudo apt-get install -y curl && \
  sudo apt-get install -y nmap && \
  sudo apt-get install -y ngrep && \
  sudo apt-get install -y tmux && \
  sudo apt-get install -y vim && \
  sudo apt-get install -y tree && \
  sudo apt-get install -y git && \
  sudo apt-get install -y shunit2 && \
  sudo apt-get install -y grip && \
  sudo apt-get install -y jq && \
  sudo apt-get install -y highlight && \
  sudo apt-get install -y pandoc && \
  sudo apt-get install -y silversearcher-ag && \
  sudo apt-get install -y ripgrep && \
  sudo apt-get install -y openjdk-8-jdk && \
  sudo apt-get install -y openjdk-11-jdk && \
  sudo apt-get install -y openssh-server && \
  sudo apt-get install -y universal-ctags && \
  sudo apt-get install -y postgresql && \
  sudo service ssh start 

  # docker
  # apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
  # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  # add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  # apt-get update
  # apt-get install -y docker-ce docker-ce-cli containerd.io

  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
  nvm install --lts

  # go?
  # clojure/lein?
  # idea ?
  # openscad?
  # kicad?

  cd ~ && git clone --depth 1 https://github.com/powerline/fonts.git
  cd ~/fonts && ./install.sh

  echo "source ~/.extrafile" >> ~/.bash_profile 
  echo "source ~/.bashrc" >> ~/.bash_profile

}

