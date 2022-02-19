#!/bin/bash

alias setup.betsy="setup_betsy"

setup_betsy() {

  sess=betsy

  ----- betsy-spec
  tmux new-session -s $sess -d -n betsy-spec
  tmux send-keys -t $sess:betsy-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-spec "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-spec
  # tmux send-keys -t $sess:betsy-spec.2 "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec.2 "cd ~/projects/betsy/betsy-spec/devtools" Enter
  tmux send-keys -t $sess:betsy-spec.2 "npm run build ../spec server ../server/ ~/projects/playground-javascript/remira-impl/services/server-nodejs/"

  tmux split-window -v -l 24 -t $sess:betsy-spec
  tmux send-keys -t $sess:betsy-spec.3 "cd ~/projects/betsy/betsy-spec/devtools" Enter
  tmux send-keys -t $sess:betsy-spec.3 "npm run build ../spec client ../client/ ~/projects/playground-javascript/remira-impl/services/client-react/"

  tmux select-pane -t $sess:betsy-spec.2

  #----- server
  tmux new-window -t $sess -n server
  tmux send-keys -t $sess:server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:server "cd ~/projects/betsy/betsy-spec/server" Enter
  tmux send-keys -t $sess:server "vim" Enter

  tmux split-window -v -l 24 -t $sess:server
  tmux send-keys -t $sess:server.2 "cd ~/projects/betsy/betsy-spec/server" Enter
  tmux select-pane -t $sess:server.1

  #----- client
  tmux new-window -t $sess -n client
  tmux send-keys -t $sess:client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:client "cd ~/projects/betsy/betsy-spec/client" Enter
  tmux send-keys -t $sess:client "vim" Enter

  tmux split-window -v -l 24 -t $sess:client
  tmux send-keys -t $sess:client.2 "cd ~/projects/betsy/betsy-spec/client" Enter
  tmux select-pane -t $sess:client.1

  #----- betsy
  tmux new-window -t $sess -n betsy
  tmux send-keys -t $sess:betsy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy "cd ~/projects/betsy/betsy" Enter
  tmux send-keys -t $sess:betsy "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy
  tmux send-keys -t $sess:betsy.2 "cd ~/projects/betsy/betsy" Enter
  tmux select-pane -t $sess:betsy.1

  #select first
  tmux select-window -t $sess:betsy-spec

  tmux -2 attach-session -t $sess
}

