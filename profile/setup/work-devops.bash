#!/bin/bash

alias setup.work.devops="setup_work_devops"

setup_work_devops() {

  # sess=${PWD##*/}
  sess=workdevops

  ### devops
  tmux new-session -s $sess -d -n devops
  tmux send-keys -t $sess:devops "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:devops "cd ~/dev/repos/devops" Enter
  tmux send-keys -t $sess:devops "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:devops
  tmux send-keys -t $sess:devops.2 "cd ~/dev/repos/devops" Enter

  tmux select-pane -t $sess:devops.1

  ### deploy (just for reference)
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter
  tmux send-keys -t $sess:deploy "vim" Enter

  tmux select-pane -t $sess:deploy.1

  # postgresql
  tmux new-window -t $sess -n postgresql
  tmux send-keys -t $sess:postgresql "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:postgresql "cd ~/dev/repos/postgresql" Enter
  tmux send-keys -t $sess:postgresql "vim" Enter

  tmux split-window -v -l 14 -t $sess:postgresql
  tmux send-keys -t $sess:postgresql.2 "cd ~/dev/repos/postgresql" Enter
  tmux send-keys -t $sess:postgresql.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:postgresql.1

  # couchbase
  tmux new-window -t $sess -n couchbase
  tmux send-keys -t $sess:couchbase "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:couchbase "cd ~/dev/repos/couchbase" Enter
  tmux send-keys -t $sess:couchbase "vim" Enter

  tmux split-window -v -l 14 -t $sess:couchbase
  tmux send-keys -t $sess:couchbase.2 "cd ~/dev/repos/couchbase" Enter
  tmux send-keys -t $sess:couchbase.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:couchbase

  # apache
  tmux new-window -t $sess -n apache
  tmux send-keys -t $sess:apache "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:apache "cd ~/dev/repos/apache" Enter
  tmux send-keys -t $sess:apache "vim" Enter

  tmux split-window -v -l 14 -t $sess:apache
  tmux send-keys -t $sess:apache.2 "cd ~/dev/repos/apache" Enter
  tmux send-keys -t $sess:apache.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:apache.1


  #select first
  tmux select-window -t $sess:devops

  tmux -2 attach-session -t $sess

}
