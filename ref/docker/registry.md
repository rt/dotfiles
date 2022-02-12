# Docker

list repos
```
curl -X GET https://registry.switchfly.com/v2/_catalog
```

list all tags
```
curl -X GET https://registry.switchfly.com:5000/v2/switchfly-jenkins/tags/list
```


jenkins uses by label `registry.switchfly.com/jenkins-slave:182`.  This needs to be pushed to our docker registry.


```
docker build -t registry.switchfly.com/jenkins-slave:182
docker push registry.switchfly.com/jenkins-slave:182
```

`switchfly/compiler` changes will be build again on UAT (probably should let Spencer know)


