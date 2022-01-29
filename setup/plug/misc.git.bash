#!/bin/bash

alias plug.misc.git="misc_git"

misc_git() {
  tmux new-window -t "$1" -n git
  tmux send-keys -t "$1":git "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":git "cd ~/projects/playground-misc/git" Enter
  tmux send-keys -t "$1":git "vim README.md" Enter
  
  tmux split-window -v -l 24 -t $1:git
  tmux send-keys -t $1:git.2 "cd ~/projects/playground-misc/git/origin" Enter

  tmux split-window -v -l 24 -t $1:git
  tmux send-keys -t $1:git.3 "cd ~/projects/playground-misc/git/client1" Enter

  tmux split-window -h -l 50 -t $1:git
  tmux send-keys -t $1:git.4 "cd ~/projects/playground-misc/git/client2" Enter

  tmux select-pane -t "$1":git.1
}
