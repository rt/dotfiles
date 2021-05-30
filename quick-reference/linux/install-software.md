#### installing software

	make && sudo make install
	# sometimes need special user, they also may specify a home anywhere
	sudo useradd -d /usr/local/var/lib/couchdb couchdb  
  sudo chown -R couchdb: /usr/local/var/{lib,log,run}/couchdb
	sudo chmod 0770 /usr/local/var/{lib,log,run}/couchdb
	/etc/init.d/couchdb start
	# start on system start
	update-rc.d couchdb default 


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



