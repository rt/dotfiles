
FROM python:3.6.5-jessie

#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl vim tmux less git build-essential
#RUN cd /root && git clone https://ryan_tsunoda@bitbucket.org/ryan_tsunoda/dotfiles.git
#RUN cd /root/dotfiles && /bin/bash -c "source ./bootstrap.sh rtsunoda"
#RUN /bin/bash -c "get_vim_bundles"

# Setup local user
#RUN groupadd -g 1100 remira && \
    #useradd -ms /bin/bash -u 1100 -g 1100 remira && \
    #mkdir /work && \
    #chown remira.remira /work

#RUN apt-get install -y zlib1g-dev libssl-dev

#WORKDIR /work/code

#USER remira

#ADD initialize.sh /work/initialize.sh

#CMD ["bash", "/work/initialize.sh"]



# notes-python

Base it off the official docs
https://docs.python.org/3/tutorial/index.html

https://docs.python.org/3/library/index.html#library-index


>Python is an easy to learn, powerful programming language. It has efficient
>high-level data structures and a simple but effective approach to
>object-oriented programming. Python’s elegant syntax and dynamic typing,
>together with its interpreted nature, make it an ideal language for scripting
>and rapid application development in many areas on most platforms.

## My Notes



