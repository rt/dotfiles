#Env for screwing around

#$docker build -t myenv .

#$docker run -it myenv

#$git clone https://ryan_tsunoda@bitbucket.org/ryan_tsunoda/dotfiles.git
#$cd dotfiles
#$source ./bootstrap rtsunoda
#$get_vim_bundles

#$docker commit <containerid> 

#Get back into the container  (tmux doesn't work > should be fixed in docker 1.14)
#$docker exec -it <containerid> /bin/bash

#If the container stopped you need to start and source your .extrafile
#$docker start <containerid>
#$source ./bootstrap rtsunoda


FROM debian:wheezy

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl vim tmux less git build-essential

RUN cd /root && git clone https://ryan_tsunoda@bitbucket.org/ryan_tsunoda/dotfiles.git

RUN cd /root/dotfiles && /bin/bash -c "source ./bootstrap.sh rtsunoda"

#RUN /bin/bash -c "get_vim_bundles()"

# Setup local user
RUN groupadd -g 1100 remira && \
    useradd -ms /bin/bash -u 1100 -g 1100 remira && \
    mkdir /work && \
    chown remira.remira /work

RUN apt-get update && \
    apt-get install -y zlib1g-dev libssl-dev

#Python
RUN curl -sSL /tmp/python-2.7.7.tgz https://www.python.org/ftp/python/2.7.7/Python-2.7.7.tgz | \
    tar -xzvf - -C /tmp/ && \
    cd /tmp/Python-2.7.7 && \
    ./configure --prefix=/usr/local/python-2.7.7 && \
    make -j 12 all && \
    make install && \
    rm -rf /tmp/Python-2.7.7



# Nodejs
ENV NODEJS_VERSION 6.9.4
ENV NODEJS_HOME /opt/nodejs
RUN curl -sSL http://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz \
    | tar xzf - -C /tmp &&\
    mv /tmp/node-v${NODEJS_VERSION}-linux-x64 ${NODEJS_HOME} &&\
    ln -s ${NODEJS_HOME}/bin/node /usr/bin/node &&\
    ln -s ${NODEJS_HOME}/bin/npm /usr/bin/npm 

ENV PATH ${PATH}:${NODEJS_HOME}/bin


WORKDIR /work/code

USER remira

#ADD initialize.sh /work/initialize.sh

#CMD ["bash", "/work/initialize.sh"]



