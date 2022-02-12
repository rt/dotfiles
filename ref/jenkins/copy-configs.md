### Copy config files

```
ssh jenkins.localhost.com
...
tar -zcf jenkins-configs.tar.gz $(find /jenkins/jobs -type f -maxdepth 4 -name config.xml) /jenkins/config.xml

# ctrl-d back to local
scp rtsunoda@jenkins.switchfly.com:/home/rtsunoda/jenkins-configs.tar.gz ~/dev/repos/jenkins-configs/
tar -xvzf jenkins-configs.tar.gz
```

