#!/bin/bash

alias plug.other.resume="other_resume"

other_resume() {
  tmux new-window -t "$1" -n resume
  tmux send-keys -t "$1":resume "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":resume "cd ~/projects/resume" Enter
  tmux send-keys -t "$1":resume "vim README.md" Enter
  
  tmux select-pane -t "$1":resume.1
}

alias plug.other.recipes="other_recipes"

other_recipes() {
  tmux new-window -t "$1" -n recipes
  tmux send-keys -t "$1":recipes "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":recipes "cd ~/projects/recipes" Enter
  tmux send-keys -t "$1":recipes "vim README.md" Enter
  
  tmux select-pane -t "$1":recipes.1
}
  
