#!/bin/bash

alias setup.betsy-client="setup_betsy-client"

setup_betsy-client() {

  sess=betsyclient

  #----- client
  tmux new-session -s $sess -d -n client
  tmux send-keys -t $sess:client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:client "cd ~/projects/betsy/betsy-client" Enter
  tmux send-keys -t $sess:client.2 "npm start"

  tmux split-window -v -l 24 -t $sess:client
  tmux send-keys -t $sess:client.2 "cd ~/projects/betsy/betsy-client" Enter
  tmux send-keys -t $sess:client.2 "npm run storybook"

  tmux split-window -v -l 24 -t $sess:client
  tmux send-keys -t $sess:client.3 "cd ~/projects/betsy/betsy-client" Enter
  tmux send-keys -t $sess:client.3 "npm run push-components ~/projects/somewhere/src/components"

  tmux select-pane -t $sess:client.1

  #----- skeleton
  tmux new-window -t $sess -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton" Enter
  tmux select-pane -t $sess:skeleton.1

  #----- betsy-old
  tmux new-window -t $sess -n betsy-old
  tmux send-keys -t $sess:betsy-old "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-old "cd ~/projects/betsy/betsy" Enter
  tmux send-keys -t $sess:betsy-old "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-old
  tmux send-keys -t $sess:betsy-old.2 "cd ~/projects/betsy/betsy" Enter
  tmux select-pane -t $sess:betsy-old.1

  #----- betsy-spec
  tmux new-window -t $sess -n betsy-spec
  tmux send-keys -t $sess:betsy-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-spec "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-spec
  tmux send-keys -t $sess:betsy-spec.2 "cd ~/projects/betsy/betsy-spec/devtools" Enter
  tmux send-keys -t $sess:betsy-spec.2 "npm run build ../spec client ../client/ ~/projects/playground-javascript/remira-impl/services/client-react/"

  tmux select-pane -t $sess:betsy-spec.2

  #select first
  tmux select-window -t $sess:client

  tmux -2 attach-session -t $sess
}

