
## Add User

	sudo adduser ryan

	#add priviledges > add user to groups
  sudo vi /etc/group



# Setup local user
RUN groupadd -g 1100 remira && \
    useradd -ms /bin/bash -u 1100 -g 1100 remira && \
    mkdir /work && \
    chown remira.remira /work

