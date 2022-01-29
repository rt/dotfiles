#!/bin/bash

alias plug.playground.java="playground_java"

playground_java() {
  tmux new-window -t "$1" -n java
  tmux send-keys -t "$1":java "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":java "cd ~/projects/playground-java" Enter
  tmux send-keys -t "$1":java "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":java
  tmux send-keys -t $1:java.2 "cd ~/projects/playground-java" Enter

  tmux select-pane -t "$1":java.1
}
