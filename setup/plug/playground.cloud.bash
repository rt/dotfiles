#!/bin/bash

alias plug.playground.cloud="playground_cloud"

playground_cloud() {
  tmux new-window -t "$1" -n cloud
  tmux send-keys -t "$1":cloud "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":cloud "cd ~/projects/playground-cloud" Enter
  tmux send-keys -t "$1":cloud "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":cloud
  tmux send-keys -t $1:cloud.2 "cd ~/projects/playground-cloud" Enter

  tmux select-pane -t "$1":cloud.1
}
