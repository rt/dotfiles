
# same as `docker container prune` ...
alias docker.rm.exited="docker rm $(docker ps -a -q -f status=exited)"

# Good for getting a docker enabled container that can connect to the host(?)
alias docker.container.connect="docker run --rm -it -v '/var/run/docker.sock:/var/run/docker.sock' docker:19.03.1 sh"


function listRegistry() {
  curl -kX GET https://$1/v2/_catalog
  # curl -X GET http://$1/v2/_catalog
  # curl -X GET https://myregistry:5000/v2/ubuntu/tags/list
}

function listRegistryRepo() {
  curl -kX GET https://$1/v2/$2/tags/list

  # curl -X GET https://registry.com/v2/application/tags/list
}

alias docker.registry.ls="listRegistry"

# ### cleanup
#
# orphaned and dangling volumes
# ```
# docker volume rm $(docker volume ls -qf dangling=true)
# ```
#
# dangling and untagged images
# ```
# docker rmi $(docker images -q -f dangling=true)
# ```
#
# delete exited containers
# ```
# docker rm $(docker ps -aqf status=exited)
# ```
#
# delete all images
# ```
# docker rmi $(docker images -q)
# ```
#
# kill all running containers
# ```
# docker kill $(docker ps -q)
# ```
#
# delete all containers
# ```
# docker rm $(docker ps -aq)
# ```



# //get into a container
# - docker exec -it <container id> /bin/bash
#
# //
# - docker logs <container id>
# - docker ps -l -q
# - docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -l -q)
#
#
# //from inside container, get host ip
# - ip addr show docker0
# - ip route show
# - //or, just 
# - hostip=$(ip route show | awk '/default/ {print $3}')
# - echo $hostip
# - //might need to allow access to host (on host)
# - iptables -A INPUT -i docker0 -j ACCEPT
#
#
# docker inspect containerid | grep IPAddress | cut -d '"' -f 4
#
# docker run -it -v "$PWD":/usr/src/app --rm -p 80:8080 --name skeleton-app-runtime skeleton-app
#
# //get ip addresses of containers
# for s in `docker-compose ps -q`; do echo ip of `docker inspect -f "{{.Name}}" $s` is `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $s`; done
#
#
# ### Docker (add good stuff back into the dockerfile)
#
#
#     #save your base
#     docker commit devenv_container
#
#     #push it so you can get it elsewhere
#     docker push devenv_container pebble/devenv
#
#     #pull to update elsewhere
#     docker pull peble/devenv
#
#     #or run
#     docker run -p 8888:8888 -v ~/projects:/root/projects -t -i pebble/devenv
#
# ### docker-compose
# `docker-compose rm -f`
# `docker-compose build --no-cache`
#
# ### networking
# Have a task to create network add nodes manually
#
# ```
# docker network ls
# docker network create my-network
# ...
# ```
#
# cli > --net=my-network will add the container (this adds to dns or hosts ... try check)
