#!/bin/bash

alias plug.misc.python="misc_python"

misc_python() {
  tmux new-window -t "$1" -n python
  tmux send-keys -t "$1":python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":python "cd ~/projects/playground-misc/python" Enter
  tmux send-keys -t "$1":python "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":python
  tmux send-keys -t "$1":python.2 "cd ~/projects/playground-misc/python" Enter

  tmux select-pane -t "$1":python.1
}

alias plug.misc.go="misc_go"

misc_go() {
  tmux new-window -t "$1" -n go
  tmux send-keys -t "$1":go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":go "cd ~/projects/playground-misc/go" Enter
  tmux send-keys -t "$1":go "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":go
  tmux send-keys -t "$1":go.2 "cd ~/projects/playground-misc/go" Enter

  tmux select-pane -t "$1":go.1
}

alias plug.misc.git="misc_git"

misc_git() {
  tmux new-window -t "$1" -n git
  tmux send-keys -t "$1":git "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":git "cd ~/projects/playground-misc/git" Enter
  tmux send-keys -t "$1":git "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":git
  tmux send-keys -t "$1":git.2 "cd ~/projects/playground-misc/git/origin" Enter

  tmux split-window -v -l 24 -t "$1":git
  tmux send-keys -t "$1":git.3 "cd ~/projects/playground-misc/git/client1" Enter

  tmux split-window -h -l 50 -t "$1":git
  tmux send-keys -t "$1":git.4 "cd ~/projects/playground-misc/git/client2" Enter

  tmux select-pane -t "$1":git.1
}
