


# docker search redis

# same as `docker container prune` ...
alias docker.rm.exited="docker rm $(docker ps -a -q -f status=exited)"

# Good for getting a docker enabled container that can connect to the host(?)
alias docker.container.connect="docker run --rm -it -v '/var/run/docker.sock:/var/run/docker.sock' docker:19.03.1 sh"


function listRegistry() {
  curl -kX GET https://$1/v2/_catalog
  # curl -X GET http://$1/v2/_catalog
  # curl -X GET https://myregistry:5000/v2/ubuntu/tags/list
}

alias docker.registry.ls="listRegistry"
