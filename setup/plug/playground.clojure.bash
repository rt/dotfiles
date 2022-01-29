#!/bin/bash

alias plug.playground.clojure="playground_clojure"

playground_clojure() {
  tmux new-window -t "$1" -n clojure
  tmux send-keys -t "$1":clojure "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":clojure "cd ~/projects/playground-clojure" Enter
  tmux send-keys -t "$1":clojure "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":clojure
  tmux send-keys -t $1:clojure.2 "cd ~/projects/playground-clojure" Enter

  tmux select-pane -t "$1":clojure.1
}
