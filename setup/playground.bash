#!/bin/bash

alias setup.playground="setup_playground"

setup_playground() {

  sess=playground

  # top
  tmux new-session -s $sess -d -n top
  tmux send-keys -t $sess:top "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:top "cd ~/projects/playground" Enter
  tmux send-keys -t $sess:top "vim" Enter

  tmux split-window -v -l 24 -t $sess:top
  tmux send-keys -t $sess:top.2 "cd ~/projects/playground/setup" Enter
  tmux send-keys -t $sess:top.2 "source ./index.bash" Enter
  tmux send-keys -t $sess:top.2 "nvm use stable" Enter

  tmux select-pane -t $sess:top.1

  plug.project.dotfiles

  #select first
  tmux select-window -t:1

  tmux -2 attach-session -t $sess

}
