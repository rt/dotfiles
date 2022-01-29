#!/bin/bash

alias plug.playground.bash="playground_bash"

playground_bash() {
  tmux new-window -t "$1" -n bash
  tmux send-keys -t "$1":bash "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":bash "cd ~/projects/playground-bash" Enter
  tmux send-keys -t "$1":bash "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":bash
  tmux send-keys -t $1:bash.2 "cd ~/projects/playground-bash" Enter

  tmux select-pane -t "$1":bash.1
}
