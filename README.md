# dotfiles


## Mac DevEnv

*.bash_profile*

```bash
touch ~/.bash_profile
touch ~/.bashrc
```

*Install Homebrew*

https://brew.sh/#install


```bash
brew update && brew tap caskroom/cask
brew install coreutils
brew install wget
brew install nmap
brew install ngrep
brew install git
brew install tmux
brew install vim
brew install tree
brew install the_silver_searcher 
brew install ripgrep
brew install fzf
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew install shUnit2
brew install grip
brew install jq
# highlighting in vim fzf preview: need to do this manually if you want the latest hightlighting
#sudo easy_install Pygments
brew install highlight
brew install pandoc
```

```bash
brew cask install caskroom/versions/java8
brew install gradle
brew install maven
brew install postgresql@9.4 
brew pin postgresql@9.4
brew cask install intellij-idea-ce
#brew cask install intellij-idea
brew cask install docker
brew cask install virtualbox
brew cleanup
```

*keyboard / arduino*

Check out the dependencies here

https://github.com/qmk/qmk_toolbox

```
brew tap osx-cross/avr
brew tap PX4/homebrew-px4
brew install avr-gcc
brew install dfu-programmer
brew install gcc-arm-none-eabi
brew install avrdude
brew install teensy_loader_cli
```

*dmg installs*

https://www.vagrantup.com/downloads.html


*projects*

add `source ~/.extrafile` to `.bash_profile`

```bash
mkdir projects
git clone https://github.com/rt/dotfiles.git
cd dotfiles/
./bootstrap rtsunoda
get_vim_bundles
```

*themes/fonts*
```bash
cd ~/projects
#powerline fonts for tmux themes and vim-airline
git clone https://github.com/powerline/fonts.git
cd fonts/
./install.sh

#optional tmux themes
cd ~/projects
git clone https://github.com/jimeh/tmux-themepack.git

#osx base16 terminals
cd ~/projects
git clone https://github.com/korzhyk/base16-terminal-app.git
```

## CI/CD Prototype

The first goal would be to have,

- one GitLab instance on docker
- CI/CD tests run on GitLab instance
- test on Kubernetes Cluster (Runners)
- push to Kubernetes Cluster (prod)
- push to CDN

Future goals might be running GitLab and/or tests on a Kubernetes Cluster as well.
https://docs.gitlab.com/ee/user/project/clusters/


###  Install (git, docker, brew, dotfiles)

Possibly could use vagrant to separate systems ...
- GitLab
- Test Runners
- Prod

*Others*
- Selenium Grid
- Dns Server
- Keroberos
- Nexus

#### GitLab

https://docs.gitlab.com/omnibus/docker/#install-gitlab-using-docker-compose

```
mkdir -p ~/mount/gitlab
docker run --detach \
  --publish 443:443 \
  --publish 80:80 \
  --publish 22:22 \
  --name gitlab \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://192.168.86.22';" \
  --restart always \
  --volume ~/mount/gitlab/config:/etc/gitlab \
  --volume ~/mount/gitlab/logs:/var/log/gitlab \
  --volume ~/mount/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```

*config: /etc/gitlab/gitlab.rb*

```
sudo docker exec -it gitlab /bin/bash
vim /etc/gitlab/gitlab.rb
...
sudo docker restart gitlab
```

*upgrade*

latest or tag gitlab/gitlab-ce:12.1.3-ce.0

```
sudo docker stop gitlab
sudo docker rm gitlab
sudo docker pull gitlab/gitlab-ce:latest
... do run command again
```

*expose ip*
```
sudo docker run --detach \
  --hostname gitlab.example.com \
  --publish 198.51.100.1:443:443 \
  --publish 198.51.100.1:80:80 \
  --publish 198.51.100.1:22:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```

#### Set up a Runner

*Stanalone*
Admin > Runners it'll give you a registration token

Linux: kubectl cp kube-apiserver-docker-desktop:run/config/pki/ca.crt -n kube-system ca.crt

https://docs.gitlab.com/runner/install/linux-repository.html


Mac, use binary https://docs.gitlab.com/runner/install/osx.html
```
sudo curl --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-darwin-amd64
sudo chmod +x /usr/local/bin/gitlab-runner
```

```
docker run -d --name gitlab-runner --restart always \
-v /srv/gitlab-runner/config:/etc/gitlab-runner \
-v /var/run/docker.sock:/var/run/docker.sock \
gitlab/gitlab-runner:latest
```

On macOS, use /Users/Shared instead of /srv.


register the runner https://docs.gitlab.com/runner/register/index.html

https://docs.gitlab.com/ee/ci/docker/using_docker_build.html

Inside of the container 
```
gitlab-runner register -n --url http://192.168.86.22 --registration-token U4ewExycnodqyyyzsjX_ --executor docker --docker-image docker:19.03.1 --description "My Runner" --docker-volumes /var/run/docker.sock:/var/run/docker.sock
```

```
#sudo gitlab-runner register 
#this only worked for me NOT using sudo and the config file is in only your home directory
gitlab-runner register
# Answer the questions with what appeared in the UI
```
Note: depending on where you grabbed your token from you may be registering a specific or shared runner. see https://docs.gitlab.com/ee/ci/runners/

Install the runner as a service and start
```
cd ~
gitlab-runner install
gitlab-runner start
```


I had to use privileged = true, and cache_dir = "cache" in config.toml otherwise could build docker in the release stage
```
concurrent = 1
check_interval = 0


[[runners]]
  name = "#####"
  url = "#####"
  token = "#####"
  executor = "docker"
  privileged = true
  cache_dir = "cache"
  [runners.docker]
    tls_verify = false
    image = "docker:latest"
    privileged = true
    disable_cache = false
    volumes = ["/cache"]
  [runners.cache]

```

*Kubernetes Executor*
TODO

#### Setting up Kubernetes in GitLab (deploy to prod)

https://edenmal.moe/post/2018/GitLab-Kubernetes-Using-GitLab-CIs-Kubernetes-Cluster-feature/

*Create Namespace*
By creating the namespace it allows us to get the default ServiceAccount (not necessarily good, see reference)
```
$ kubectl create -f manifests/namespace.yaml
```

*Get ServiceAccount Token*
```
$ kubectl get -n presentation-gitlab-k8s secret
```

Get the NAME outputted from the above command to get the encoded token
```
kubectl get -n presentation-gitlab-k8s secret <NAME> -o yaml
```

Look for data > token: and decode it
```
echo YOUR_TOKEN_HERE | base64 -d
```

*Get Kubernetes CA Certificate*

For docker-desktop you can do the following
```
kubectl cp kube-apiserver-docker-desktop:run/config/pki/ca.crt -n kube-system ca.crt
```

As noted in the reference, if you have a kubernetes provider it might be in `/.kube/config` under `certificate-authority`

*API URL*

```
$ kubectl cluster-info | grep 'Kubernetes master' | awk '/http/ {print $NF}'
# https://kubernetes.docker.internal:6443
```
There will be a validation error you need allow request from the local network in GitLab
Admin -> Settings -> Network -> Outbound Requests -> Allow requests to the local network from hooks and services


Now you can Add Kubernetes Cluster in GitLab
- Kubernetes cluster name: skeleton prod (any name)
- Environment scope: *
- API URL: from above
- CA Certificate: from above (full copy PEM format)
- Token: from above decoded token
-



#### Kubernetes (Server Prod)

```
brew install kubernetes-cli
# select Kubernetes > docker-for-desktop in UI
kubectl config use-context docker-for-desktop
kubectl config current-context
kubectl config view
```

*Basic Pod*

pod.yaml
```
kind: Pod
apiVersion: v1
metadata:
  name: example-pod
spec:
  containers:
    - image: nginx
      name: example-container
```

```
kubectl create -f pod.yaml
kubectl get pods
```
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl proxy
# visit http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

```

#### CDN (Client Prod)

https://idiallo.com/blog/creating-your-own-cdn-with-nginX
https://community.akamai.com/customers/s/article/How-to-make-a-simple-CDN-for-testing?language=en_US

```
```
