FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get update && apt-get install -y ubuntu-server
RUN apt-get update && \
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
  service ssh start 

# docker
# RUN apt-get remove docker docker-engine docker.io containerd runc
RUN apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

# 
RUN apt-get install -y universal-ctags

# postgres
RUN apt-get install -y postgresql

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

# clojure
# RUN curl -O https://download.clojure.org/install/linux-install-1.10.1.727.sh
# RUN chmod +x linux-install-1.10.1.727.sh
# RUN ./linux-install-1.10.1.727.sh


# nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

RUN cd ~ && git clone --depth 1 https://github.com/powerline/fonts.git
RUN cd ~/fonts && ./install.sh

RUN cd ~ && git clone --depth 1 https://github.com/rt/dotfiles.git
RUN mkdir ~/.vim
RUN cd ~/dotfiles/ && ./bootstrap work_linux
RUN cd ~ && rm -rf dotfiles

# install lein
# RUN ~/bin/lein

RUN echo "source ~/.extrafile" >> ~/.bash_profile 
RUN echo "source ~/.bashrc" >> ~/.bash_profile

