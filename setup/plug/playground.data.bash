#!/bin/bash

alias plug.playground.data="playground_data"

playground_data() {
  tmux new-window -t "$1" -n data
  tmux send-keys -t "$1":data "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":data "cd ~/projects/playground-data" Enter
  tmux send-keys -t "$1":data "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":data
  tmux send-keys -t $1:data.2 "cd ~/projects/playground-data" Enter

  tmux select-pane -t "$1":data.1
}
