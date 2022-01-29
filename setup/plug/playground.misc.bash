#!/bin/bash

alias plug.playground.misc="playground_misc"

playground_misc() {
  tmux new-window -t "$1" -n misc
  tmux send-keys -t "$1":misc "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":misc "cd ~/projects/playground-misc" Enter
  tmux send-keys -t "$1":misc "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":misc
  tmux send-keys -t $1:misc.2 "cd ~/projects/playground-misc" Enter

  tmux select-pane -t "$1":misc.1
}
