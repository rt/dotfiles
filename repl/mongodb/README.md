# MongoDB

https://docs.mongodb.com/v4.4/mongo/


```bash
docker run --rm --name mongodb -p 27017:27017 -d mongo:latest

docker run --rm --name mongodb -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=admin -d mongo:latest

docker logs mongo
docker kill mongodb
```

```bash
mongosh
mongosh --username admin --password admin
mongosh "mongodb://localhost:27017"
mongosh --host mongodb0.example.com --port 28015

```

```yaml
version: '3.1'

services:

  mongo:
    image: mongo
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example

  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: example
      ME_CONFIG_MONGODB_URL: mongodb://root:example@mongo:27017/
```
