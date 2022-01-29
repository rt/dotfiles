#!/bin/bash

alias plug.project.yoteam="project_yoteam"

project_yoteam() {
  tmux new-window -t "$1" -n yoteam
  tmux send-keys -t "$1":yoteam "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":yoteam "cd ~/projects/yoteam" Enter
  tmux send-keys -t "$1":yoteam "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":yoteam
  tmux send-keys -t $1:yoteam.2 "cd ~/projects/yoteam" Enter

  tmux select-pane -t "$1":yoteam.1
}
