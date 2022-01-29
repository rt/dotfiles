#!/bin/bash

alias plug.project.remira="project_remira"

project_remira() {
  tmux new-window -t "$1" -n remira
  tmux send-keys -t "$1":remira "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":remira "cd ~/projects/remira" Enter
  tmux send-keys -t "$1":remira "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":remira
  tmux send-keys -t $1:remira.2 "cd ~/projects/remira" Enter

  tmux select-pane -t "$1":remira.1
}
