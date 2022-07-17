#!/bin/bash

alias setup.playground="setup_playground"
alias p.pane="p_pane"
alias p.plug="p_plug"

p_plug() {
  tmux new-window -t "$1" -n playground
  tmux send-keys -t "$1":playground "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":playground "cd ~/projects/playground" Enter
  tmux send-keys -t "$1":playground Escape "c"
}

p_pane() {
  tmux split-window -v -l 24 -t "$1":"$2" 
  # because specifying pane 2 this needs to be executed in empty terminal
  tmux send-keys -t "$1":"$2".2 "cd ~/projects/playground" Enter
  tmux send-keys -t "$1":"$2".2 "vim.find" Enter
  tmux swap-pane -U
}

setup_playground() {

  sess=playground

  # top
  tmux new-session -s $sess -d -n top
  tmux send-keys -t $sess:top "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:top "cd ~/projects/playground" Enter
  tmux send-keys -t $sess:top "nvm use stable" Enter

  plug.project.dotfiles

  #select first
  tmux select-window -t:1

  tmux -2 attach-session -t $sess

}
