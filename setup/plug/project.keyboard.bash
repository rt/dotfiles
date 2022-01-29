#!/bin/bash

alias plug.project.keyboard="project_keyboard"

project_keyboard() {
  tmux new-window -t "$1" -n keyboard
  tmux send-keys -t "$1":keyboard "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":keyboard "cd ~/projects/keyboard" Enter
  tmux send-keys -t "$1":keyboard "vim README.md" Enter
  
  tmux split-window -v -l 24 -t $1:keyboard
  tmux send-keys -t $1:keyboard.2 "cd ~/projects/keyboard/" Enter
  tmux send-keys -t $1:keyboard.2 "./copy_qmk_files"

  tmux split-window -h -l 50 -t $1:keyboard
  tmux send-keys -t $1:keyboard.3 "cd ~/projects/qmk_firmware" Enter
  tmux send-keys -t $1:keyboard.3 "make handwired/mrkabuda:ryan:avrdude"

  tmux select-pane -t "$1":keyboard.1
}
