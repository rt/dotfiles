#!/bin/bash

alias setup.ecom_client="setup_ecom_client"

setup_ecom_client() {

  sess=ecomclient

  #----- skeleton
  tmux new-session -s $sess -d -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton-spec" Enter

  #----- client
  tmux new-window -t $sess -n client
  tmux send-keys -t $sess:client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:client "cd ~/projects/ecom/ecom-client" Enter
  tmux send-keys -t $sess:client "vim" Enter

  tmux split-window -v -l 24 -t $sess:client
  tmux send-keys -t $sess:client.2 "cd ~/projects/ecom/ecom-client" Enter

  tmux select-pane -t $sess:client.1

  #----- spec
  tmux new-window -t $sess -n spec
  tmux send-keys -t $sess:spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:spec "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:spec
  tmux send-keys -t $sess:spec.2 "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:spec.2 "npm run build  ~/projects/ecom/ecom-spec client ~/projects/ecom/ecom-client/"

  tmux select-pane -t $sess:spec.1

  #----- clib
  tmux new-window -t $sess -n clib
  tmux send-keys -t $sess:clib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clib "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:clib "vim" Enter

  tmux split-window -v -l 24 -t $sess:clib
  tmux send-keys -t $sess:clib.2 "cd ~/projects/skeleton/component-library" Enter

  tmux select-pane -t $sess:clib.1


  #select first window
  tmux select-window -t $sess:client

  tmux -2 attach-session -t $sess

}

