### cleanup

orphaned and dangling volumes
```
docker volume rm $(docker volume ls -qf dangling=true)
```

dangling and untagged images
```
docker rmi $(docker images -q -f dangling=true)
```

delete exited containers
```
docker rm $(docker ps -aqf status=exited)
```

delete all images
```
docker rmi $(docker images -q)
```

kill all running containers
```
docker kill $(docker ps -q)
```

delete all containers
```
docker rm $(docker ps -aq)
```


