#!/bin/bash

alias plug.project.dotfiles="project_dotfiles"

project_dotfiles() {
  tmux new-window -t "$1" -n dotfiles
  tmux send-keys -t "$1":dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t "$1":dotfiles "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":dotfiles
  tmux send-keys -t $1:dotfiles.2 "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $1:dotfiles.2 "./bootstrap rtsunoda"

  tmux select-pane -t "$1":dotfiles.1
}
