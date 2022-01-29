#!/bin/bash

alias plug.misc.go="misc_go"

misc_go() {
  tmux new-window -t "$1" -n go
  tmux send-keys -t "$1":go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":go "cd ~/projects/playground-misc/go" Enter
  tmux send-keys -t "$1":go "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":go
  tmux send-keys -t $1:go.2 "cd ~/projects/playground-misc/go" Enter

  tmux select-pane -t "$1":go.1
}
