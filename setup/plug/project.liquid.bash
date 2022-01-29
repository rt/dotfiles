#!/bin/bash

alias plug.project.liquid="project_liquid"

project_liquid() {
  tmux new-window -t "$1" -n liquid
  tmux send-keys -t "$1":liquid "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":liquid "cd ~/projects/liquid" Enter
  tmux send-keys -t "$1":liquid "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":liquid
  tmux send-keys -t $1:liquid.2 "cd ~/projects/liquid" Enter

  tmux select-pane -t "$1":liquid.1
}
