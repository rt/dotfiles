FROM node:fermium

#pm2
RUN npm install pm2 -g

#Only changes to package.json will make docker build node_modules again
COPY ./build/package.json /tmp/package.json
COPY ./build/package-lock.json /tmp/package-lock.json
RUN cd /tmp && npm ci


RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app/


#Load app code (previous node_modules layer will be cached if possible)
WORKDIR /usr/src/app
COPY ./build /usr/src/app

EXPOSE 5000


#CMD [ "npm", "start" ]
CMD ["pm2-docker", "server.js"]
