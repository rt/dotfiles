# Dockerfiles

Container Tools

### Building

From child directory

```bash
docker login
docker build -t pebble/devenv .
docker push pebble/devenv
```

## Usage

One common issue will be that work done in a container with mapped volumes will have the owner as `root`
but you will commit on the host giving permission problems.

On the host, in the repo.
```bash
chown -R $(whoami) .git
```

### Mac usage

Follow Mac install

```bash
# sudo docker pull pebble/devenv
sudo docker run -it -v "$PWD:/root/projects" pebble/devenv
```

### Cloud instance usage

- Ubuntu (minimal?)

```bash
sudo apt-get curl
```

**Docker**

```bash
sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

```bash
# sudo docker pull pebble/devenv
sudo docker run -it -v "$PWD:/root/projects" pebble/devenv
```
