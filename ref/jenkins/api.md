# Jenkins

https://jenkins.switchfly.com/
http://jenkins.shared-resources.ash.oci.ezrez/jenkins

### Creds 

Jenkins OCI: 11b804bac1f0cdfbad0ff8c68c4420142b

```bash
# start a job
curl -X POST http://jenkins.shared-resources.ash.oci.ezrez/jenkins/job/job1/build --user rtsunoda:11b804bac1f0cdfbad0ff8c68c4420142b

# list jobs
curl -X GET http://jenkins.shared-resources.ash.oci.ezrez/jenkins/api/json?pretty=true 

# schedule a job with some delay
curl -X POST http://localhost:8080/job/job1/build?delay=10sec  --user jenkins:f1499cc9852c899d327a1f644e61a64d

# build job with params
curl -X POST http://localhost:8080/job/job1/build  \
  -jenkins:f1499cc9852c899d327a1f644e61a64d \
  --data-urlencode json='{"parameter": [{"name":"id", "value":"100"}, {"name":"loglevel", "value":"high"}]}'

# delete job
curl -X POST http://localhost:8080/job/job1/doDelete --user jenkins:f1499cc9852c899d327a1f644e61a64d

# delete bulk builds
curl -X POST http://localhost:8080/job/job1/[1-100]/doDelete --user jenkins:f1499cc9852c899d327a1f644e61a64d

```

```
:r !curl http://jenkins.shared-resources.ash.oci.ezrez/jenkins/job/stable/api/json?pretty=true
```
curl -X GET http://jenkins.shared-resources.ash.oci.ezrez/jenkins/api/json?pretty=true 

### Using Api

It would be useful to connect the setting on Jenkins with the codebase.

Could write a script to connect (dev groovy scrpits, devops groovy scripts, jenkins)
- transverse jobs json (if it has "jobs" dig, if it is "buildable", get config.xml)
- each leaf job need to look at config.xml

Could submit to createqa, Adhoc test 

```
https://jenkins.switchfly.com/api/json?tree=jobs[name,color]
```

