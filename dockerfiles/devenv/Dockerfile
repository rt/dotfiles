FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get update && apt-get install -y ubuntu-server
RUN apt-get update && \
  apt-get install -y coreutils && \
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

# RUN tmux new -s mysesh

# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

# nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
# RUN source ~/.bashrc
# RUN nvm use

RUN git clone https://github.com/powerline/fonts.git
RUN cd fonts/ && ./install.sh
