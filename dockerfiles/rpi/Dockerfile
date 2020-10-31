# THIS NEEDS TO BE BUILT ON ARM (or, an emulator)

FROM resin/rpi-raspbian
RUN apt-get update && \
    apt-get -qy install wget unzip \
                build-essential python \
                ca-certificates

WORKDIR /root/
RUN wget \
  https://nodejs.org/dist/latest-boron/node-v6.11.3-linux-armv6l.tar.gz
RUN tar -xvf node-*.tar.gz -C /usr/local \
  --strip-components=1

#RUN curl -O \  
  #https://nodejs.org/dist/v4.5.0/node-v4.5.0-linux-armv6l.tar.gz
#RUN tar -xvf node-*.tar.gz -C /usr/local \  
  #--strip-components=1

#pm2 problem installing???
#RUN npm install pm2 -g

#GPIO, but would have to call python scripts from node
#RUN apt-get -q update && \  
    #apt-get -qy install \
        #python python-pip \
        #python-dev python-pip gcc make  

#RUN pip install rpi.gpio  

#Only changes to package.json will make docker build node_modules again
COPY ./build/package.json /tmp/package.json
RUN cd /tmp && npm install


RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app/


#Load app code (previous node_modules layer will be cached if possible)
WORKDIR /usr/src/app
COPY ./build /usr/src/app

EXPOSE 3000


#CMD [ "npm", "start" ]
CMD ["pm2-docker", "server.js"]
#CMD pm2-docker server.js

