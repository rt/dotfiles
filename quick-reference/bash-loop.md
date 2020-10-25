**Basics**
```bash
for VARIABLE in 1 2 3 4 5 .. N
#for i in {1..5}
#for i in {0..10..2}  Bash v4+ supports increment {start..end..inc}
do
	command on $VARIABLE
done

for VARIABLE in file1 file2 file3
#for OUTPUT in $(command)
do
	command on $VARIABLE
done
```

**Break**
```bash
for file in /etc/*
do
	if [ "${file}" == "/etc/resolv.conf" ]
	then
		countNameservers=$(grep -c nameserver /etc/resolv.conf)
		echo "Total  ${countNameservers} nameservers defined in ${file}"
		break
	fi
done
```

**Continue**
```bash
FILES="$@"
for f in $FILES
do
        # if .bak backup file exists, read next file
	if [ -f ${f}.bak ]
	then
		echo "Skiping $f file..."
		continue  # read next file and skip the cp command
	fi
        # we are here means no backup file exists, just use cp command to copy file
	/bin/cp $f $f.bak
done
```

**Three expression loops (c style)**
```bash
for (( c=1; c<=5; c++ ))
do  
   echo "Welcome $c times"
done

for (( ; ; ))
do
   echo "infinite loops [ hit CTRL+C to stop]"
done
```

**Array Elements**
```bash
DB_AWS_ZONE=('us-east-2a' 'us-west-1a' 'eu-central-1a')

for zone in "${DB_AWS_ZONE[@]}"
do
  echo "Creating rds (DB) server in $zone, please wait ..."
  aws rds create-db-instance \
  --availability-zone "$zone"
  --allocated-storage 20 --db-instance-class db.m1.small \
  --db-instance-identifier test-instance \
  --engine mariadb \
  --master-username my_user_name \
  --master-user-password my_password_here
done
```

**Shell variable string splits**
Sometimes we store important data in the shell variable, and we can use for a loop as follows to read the data
```bash
_admin_ip="202.54.1.33|MUM_VPN_GATEWAY 23.1.2.3|DEL_VPN_GATEWAY 13.1.2.3|SG_VPN_GATEWAY"
for e in $_admin_ip
do
   echo "${e%%|*}" to ${e##*|}
done
```

**Loop with a number**
```bash
## example: ping cbz01, cbz02, cbz03, and cbz04 using a loop ##
for i in 0{1..4}
do
    h="cbz${i}"
    ping -c 1 -q "$h" &>/dev/null
    if [ $? -eq 0 ]
    then
        echo "server $h alive"
    else
        echo "server $h dead or can not ping."
    fi
done
```

**Loop with strings**
```bash
PKGS="php7-openssl-7.3.19-r0  php7-common-7.3.19-r0  php7-fpm-7.3.19-r0  php7-opcache-7.3.19-r0 php7-7.3.19-r0"
for p in $PKGS
do
   echo "Installing $p package"
   sudo apk add "$p"
done
```
