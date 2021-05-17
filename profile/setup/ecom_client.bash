#!/bin/bash

alias setup.ecom_client="setup_ecom_client"

setup_ecom_client() {

  sess=ecomclient

  #----- ecom-client
  tmux new-session -s $sess -d -n ecom-client
  tmux send-keys -t $sess:ecom-client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-client "cd ~/projects/ecom/ecom-client" Enter
  tmux send-keys -t $sess:ecom-client "vim" Enter

  tmux split-window -v -l 24 -t $sess:ecom-client
  tmux send-keys -t $sess:ecom-client.2 "cd ~/projects/ecom/ecom-client" Enter

  tmux select-pane -t $sess:ecom-client.1

  #----- ecom-spec
  tmux new-window -t $sess -n ecom-spec
  tmux send-keys -t $sess:ecom-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-spec "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:ecom-spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:ecom-spec
  tmux send-keys -t $sess:ecom-spec.2 "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:ecom-spec.2 "npm run build  ~/projects/ecom/ecom-spec client ~/projects/ecom/ecom-client/"

  tmux select-pane -t $sess:ecom-spec.1

  #----- clib
  tmux new-window -t $sess -n clib
  tmux send-keys -t $sess:clib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clib "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:clib "vim" Enter

  tmux split-window -v -l 24 -t $sess:clib
  tmux send-keys -t $sess:clib.2 "cd ~/projects/skeleton/component-library" Enter

  tmux select-pane -t $sess:clib.1


  #select first window
  tmux select-window -t $sess:ecom-client

  tmux -2 attach-session -t $sess

}

