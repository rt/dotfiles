#!/bin/bash

alias setup.ecom_server="setup_ecom_server"

setup_ecom_server() {

  sess=ecomserver

  #----- spec
  tmux new-session -s $sess -d -n spec
  tmux send-keys -t $sess:spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:spec "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:spec
  tmux send-keys -t $sess:spec.2 "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:spec.2 "npm run build ~/projects/ecom/ecom-spec server ~/projects/ecom/ecom-server/"

  tmux select-pane -t $sess:spec.1

  #----- server
  tmux new-window -t $sess -n server
  tmux send-keys -t $sess:server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:server "cd ~/projects/betsy/betsy-server" Enter
  tmux send-keys -t $sess:server "vim" Enter

  tmux split-window -v -l 5 -t $sess:server
  tmux send-keys -t $sess:server.2 "cd ~/projects/ecom/ecom-server" Enter
  tmux send-keys -t $sess:server.2 "./gradlew build"

  tmux select-pane -t $sess:server.2

  #----- devtools
  tmux new-window -t $sess -n devtools
  tmux send-keys -t $sess:devtools "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:devtools "cd ~/projects/ecom/ecom-server/devtools/" Enter

  tmux split-window -v -l 12 -t $sess:devtools
  tmux send-keys -t $sess:devtools.2 "cd ~/projects/ecom/ecom-server/devtools/" Enter
  tmux send-keys -t $sess:devtools.2 "npm run something"

  tmux select-pane -t $sess:devtools.1

  #select first window
  tmux select-window -t $sess:spec

  tmux -2 attach-session -t $sess

}

