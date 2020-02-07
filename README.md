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

The first goal would be to have ,

- one GitLab instance on docker
- CI/CD tests run on GitLab instance
- push to Kubernetes Cluster (prod)

Future goals might be running GitLab and/or tests on a Kubernetes Cluster as well.
https://docs.gitlab.com/ee/user/project/clusters/


###  Install (git, docker, brew, dotfiles)

Possibly could use vagrant to separate systems ...
- GitLab
- Test Env
- Prod

*Others*
- Dns Server
- Nexus
- Selenium Grid
- Keroberos

#### GitLab

https://docs.gitlab.com/omnibus/docker/#install-gitlab-using-docker-compose

```
docker run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
```

*config: /etc/gitlab/gitlab.rb*

```
sudo docker exec -it gitlab /bin/bash
vim /etc/gitlab/gitlab.rb
...
sudo docker restart gitlab
```

Or, configure on the run command (GITLAB_OMNIBUS)
```
sudo docker run --detach \
  --hostname gitlab.example.com \
  --env GITLAB_OMNIBUS_CONFIG="external_url 'http://my.domain.com/'; gitlab_rails['lfs_enabled'] = true;" \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab \
  --volume /srv/gitlab/logs:/var/log/gitlab \
  --volume /srv/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest
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

#### Kubernetes (Server Prod)

```
brew install kubernetes-cli
# select Kubernetes > docker-for-desktop in UI
kubectl config use-context docker-for-desktop
kubectl config current-context
kubectl config view
```

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
