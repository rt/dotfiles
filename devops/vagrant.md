# Vagrant

```bash
vagrant --version

vagrant box add ubuntu/trusty64
vagrant box add ubuntu/xenial64
vagrant box add ubuntu/bionic64

vagrant box list 


vagrant ssh-config
vagrant port <vagrant machine>
#vagrant plugin install vagrant-ip-show
#vagrant ip-show
vagrant ssh -c "ip addr"

# Often used vagrant cli commands
vagrant status
vagrant global-status
vagrant up
vagrant halt
vagrant suspend
vagrant destroy
vagrant port


cd ~/vms/ubuntu/
vagrant init ubuntu/bionic64
vagrant up

vagrant global-status

vagrant ssh  #creds vagrant/vagrant
```
