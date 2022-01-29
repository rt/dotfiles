#!/bin/bash

alias plug.playground.javascript="playground_javascript"

playground_javascript() {
  tmux new-window -t "$1" -n javascript
  tmux send-keys -t "$1":javascript "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":javascript "cd ~/projects/playground-javascript" Enter
  tmux send-keys -t "$1":javascript "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":javascript
  tmux send-keys -t $1:javascript.2 "cd ~/projects/playground-javascript" Enter

  tmux select-pane -t "$1":javascript.1
}
