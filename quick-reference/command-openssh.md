**config file**

- system wide: /etc/ssh/ssh_config
- user: ~/.ssh/config

Example entry

```
Host server1
     HostName server1.cyberciti.biz
     User nixcraft
     Port 4242
     IdentityFile /nfs/shared/users/nixcraft/keys/server1/id_rsa

Host nas01
     HostName 192.168.1.100
     User root
     IdentityFile ~/.ssh/nas01.key
```

```bash
ssh server1
```


Without a config it's more to write

```bash
ssh -i private_key_file -p port user@host 
```

**References**

https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix/

