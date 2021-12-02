# Get Instance on oci

- Select uat compartment
- Select images (ubuntu, minimal is probably fine)
- Select size/shape
- Select use existing network (But change compartment to uat, and subnet to app)
- Use public key (so you don't have to keep another private one) 

**Connect**

```
ssh ubuntu@10.70.80.155
```

**Get Docker**

```
sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

**Get code**

- The host will need ssh keys for gitlab (dev, devops) and bitbucket (work)
```bash
ssh-keygen
less ~/.ssh/id_rsa.pub
...
git clone --depth 1 devops   # gitlab
git clone --depth 1 dotfiles # github
git clone --depth 1 work     # bitbucket
```

**Get env**

```bash
docker pull pebble/devenv
```

```bash
# don't add --rm because you will create ~/.bash_profile and other dotfiles ...
sudo docker run -it -v "$PWD/projects":/root/projects -v "$PWD/dev":/root/dev devenv
echo "source ~/.extrafile" > ~/.bash_profile
source ~/.bash_profile
nvm install --lts
```

To get back in
```bash
sudo docker exec -it <containerId> bash
```

