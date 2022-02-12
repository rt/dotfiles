
For dockerhub, pushing means publishing (unless private)
Should do this with Travis or CircleCi for devenv
```bash
# defaults to dockerhub
docker login --username=yourhubusername 

# optionally, tag image
docker images
docker tag <id> pebble/devenv:mytag

docker push pebble/devenv
```
