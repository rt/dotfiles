alias linux.install.tools="install_linux_tools"

# very similar to dockerfiles/devenv
install_linux_tools() {
  apt-get update && \
  apt-get install -y coreutils && \
  apt-get install -y iputils-ping && \
  apt-get install -y wget && \
  apt-get install -y curl && \
  apt-get install -y nmap && \
  apt-get install -y ngrep && \
  apt-get install -y tmux && \
  apt-get install -y vim && \
  apt-get install -y tree && \
  apt-get install -y git && \
  apt-get install -y shunit2 && \
  apt-get install -y grip && \
  apt-get install -y jq && \
  apt-get install -y highlight && \
  apt-get install -y pandoc && \
  apt-get install -y silversearcher-ag && \
  apt-get install -y ripgrep && \
  apt-get install -y openjdk-8-jdk && \
  apt-get install -y openjdk-11-jdk && \
  apt-get install -y openssh-server && \
  apt-get install -y universal-ctags && \
  apt-get install -y postgresql && \
  service ssh start 

  # docker
  apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io

  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

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

