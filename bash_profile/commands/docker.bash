alias docker.registry.list="listRegistry"
alias docker.rm.exited="docker rm $(docker ps -a -q -f status=exited)" # same as `docker container prune` ...

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


