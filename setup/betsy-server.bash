#!/bin/bash

alias setup.betsy-server="setup_betsy-server"

setup_betsy-server() {

  sess=betsyserver

  #----- server
  tmux new-session -s $sess -d -n server
  tmux send-keys -t $sess:server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:server "cd ~/projects/betsy/betsy-server" Enter
  tmux send-keys -t $sess:server "vim" Enter

  tmux split-window -v -l 24 -t $sess:server
  tmux send-keys -t $sess:server.2 "cd ~/projects/betsy/betsy-server" Enter
  tmux select-pane -t $sess:server.1

  #----- migrations
  tmux new-window -t $sess -n migrations
  tmux send-keys -t $sess:migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:migrations "cd ~/projects/betsy/betsy-server/src/modules/betsy/data/migrations" Enter
  tmux send-keys -t $sess:migrations "vim" Enter

  tmux split-window -v -l 24 -t $sess:migrations
  tmux send-keys -t $sess:migrations.2 "cd ~/projects/betsy/betsy-server/src/modules/betsy/data/migrations" Enter
  tmux send-keys -t $sess:migrations.2 "psql -U postgres -h localhost" Enter
  tmux select-pane -t $sess:migrations.1

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
  # tmux send-keys -t $sess:betsy-spec.2 "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec.2 "cd ~/projects/betsy/betsy-spec/devtools" Enter
  tmux send-keys -t $sess:betsy-spec.2 "npm run build ../spec server ../server/ ~/projects/playground-javascript/remira-impl/services/server-nodejs/"

  tmux select-pane -t $sess:betsy-spec.2

  #select first
  tmux select-window -t $sess:server

  tmux -2 attach-session -t $sess
}

