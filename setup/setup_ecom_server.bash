#!/bin/bash

setup_ecom_server() {

  sess=ecomserver

  #----- ecom-spec
  tmux new-session -s $sess -d -n ecom-spec
  tmux send-keys -t $sess:ecom-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-spec "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:ecom-spec "vim" Enter
  tmux select-pane -t $sess:ecom-spec.1

  #----- ecom-server
  tmux new-window -t $sess -n ecom-server
  tmux send-keys -t $sess:ecom-server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-server "cd ~/projects/ecom/ecom-server" Enter
  tmux send-keys -t $sess:ecom-server "npm run build ~/projects/ecom/ecom-spec server ~/projects/ecom/ecom-server/"
  tmux select-pane -t $sess:ecom-server.1

  #----- ecom-devtools
  tmux new-window -t $sess -n ecom-devtools
  tmux send-keys -t $sess:ecom-devtools "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-devtools "cd ~/projects/ecom/ecom-server/devtools/" Enter
  tmux select-pane -t $sess:ecom-devtools.1

  #select first window
  tmux select-window -t $sess:ecom-spec

  tmux -2 attach-session -t $sess

}

