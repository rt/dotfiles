#!/bin/bash

alias setup.betsy="setup_betsy"

setup_betsy() {

  sess=betsy

  #----- skeleton
  tmux new-session -s $sess -d -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton-spec" Enter

  #----- spec
  tmux new-window -t $sess -n spec
  tmux send-keys -t $sess:spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:spec "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:spec
  # tmux send-keys -t $sess:spec.2 "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:spec.2 "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:spec.2 "npm run build ~/projects/betsy/betsy-spec server ~/projects/betsy/betsy-server/"


  tmux split-window -v -l 24 -t $sess:spec
  # tmux send-keys -t $sess:spec.3 "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:spec.3 "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:spec.3 "npm run build ~/projects/betsy/betsy-spec client ~/projects/betsy/betsy-client/"

  tmux select-pane -t $sess:spec.2

  #----- server
  tmux new-window -t $sess -n server
  tmux send-keys -t $sess:server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:server "cd ~/projects/betsy/betsy-server" Enter
  tmux send-keys -t $sess:server "vim" Enter

  tmux split-window -v -l 24 -t $sess:server
  tmux send-keys -t $sess:server.2 "cd ~/projects/betsy/betsy-server" Enter
  tmux select-pane -t $sess:server.1

  #----- client
  tmux new-window -t $sess -n client
  tmux send-keys -t $sess:client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:client "cd ~/projects/betsy/betsy-client" Enter
  tmux send-keys -t $sess:client "vim" Enter

  tmux split-window -v -l 24 -t $sess:client
  tmux send-keys -t $sess:client.2 "cd ~/projects/betsy/betsy-client" Enter
  tmux select-pane -t $sess:client.1

  #----- clib
  tmux new-window -t $sess -n clib
  tmux send-keys -t $sess:clib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clib "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:clib "vim" Enter

  tmux split-window -v -l 24 -t $sess:clib
  tmux send-keys -t $sess:clib.2 "cd ~/projects/skeleton/component-library" Enter
  tmux select-pane -t $sess:clib.1

  #----- old
  tmux new-window -t $sess -n old
  tmux send-keys -t $sess:old "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:old "cd ~/projects/betsy/betsy-old" Enter
  tmux send-keys -t $sess:old "vim" Enter

  tmux split-window -v -l 24 -t $sess:old
  tmux send-keys -t $sess:old.2 "cd ~/projects/betsy/betsy-old" Enter
  tmux select-pane -t $sess:old.1

  #select first
  tmux select-window -t $sess:spec

  tmux -2 attach-session -t $sess
}

