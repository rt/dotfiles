### networking

Have a task to create network add nodes manually

```
docker network ls
docker network create my-network
...
```

cli > --net=my-network will add the container (this adds to dns or hosts ... try check)

# //from inside container, get host ip
# - ip addr show docker0
# - ip route show
# - //or, just 
# - hostip=$(ip route show | awk '/default/ {print $3}')
# - echo $hostip
# - //might need to allow access to host (on host)
# - iptables -A INPUT -i docker0 -j ACCEPT

# docker inspect containerid | grep IPAddress | cut -d '"' -f 4

# - docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -l -q)


# //get ip addresses of containers
# for s in `docker-compose ps -q`; do echo ip of `docker inspect -f "{{.Name}}" $s` is `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $s`; done

