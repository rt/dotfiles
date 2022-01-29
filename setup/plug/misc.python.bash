#!/bin/bash

alias plug.misc.python="misc_python"

misc_python() {
  tmux new-window -t "$1" -n python
  tmux send-keys -t "$1":python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":python "cd ~/projects/playground-misc/python" Enter
  tmux send-keys -t "$1":python "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":python
  tmux send-keys -t $1:python.2 "cd ~/projects/playground-misc/python" Enter

  tmux select-pane -t "$1":python.1
}
