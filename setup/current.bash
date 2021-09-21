#!/bin/bash

alias setup.current="setup_current"

setup_current() {

  sess=current

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

  #----- component-library
  tmux new-window -t $sess -n component-library
  tmux send-keys -t $sess:component-library "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:component-library "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:component-library "vim" Enter

  tmux split-window -v -l 24 -t $sess:component-library
  tmux send-keys -t $sess:component-library.2 "cd ~/projects/skeleton/component-library" Enter

  tmux select-pane -t $sess:component-library.1

  #----- betsy-old
  tmux new-window -t $sess -n betsy-old
  tmux send-keys -t $sess:betsy-old "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-old "cd ~/projects/betsy/betsy-old" Enter
  tmux send-keys -t $sess:betsy-old "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-old
  tmux send-keys -t $sess:betsy-old.2 "cd ~/projects/betsy/betsy-old" Enter
  tmux select-pane -t $sess:betsy-old.1

  #----- skeleton
  tmux new-window -t $sess -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton" Enter

  tmux select-pane -t $sess:skeleton.1

  #select first
  tmux select-window -t $sess:betsy-spec

  tmux -2 attach-session -t $sess
}

