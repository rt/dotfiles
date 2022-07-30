#!/bin/bash

alias plug.project.dotfiles="project_dotfiles"

project_dotfiles() {
  tmux new-window -t "$1" -n dotfiles
  tmux send-keys -t "$1":dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t "$1":dotfiles "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":dotfiles
  tmux send-keys -t "$1":dotfiles.2 "cd ~/projects/dotfiles" Enter
  tmux send-keys -t "$1":dotfiles.2 "./bootstrap rtsunoda"

  tmux select-pane -t "$1":dotfiles.1
}

alias plug.project.keyboard="project_keyboard"

project_keyboard() {
  tmux new-window -t "$1" -n keyboard
  tmux send-keys -t "$1":keyboard "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":keyboard "cd ~/projects/keyboard" Enter
  tmux send-keys -t "$1":keyboard "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":keyboard
  tmux send-keys -t "$1":keyboard.2 "cd ~/projects/keyboard/" Enter
  tmux send-keys -t "$1":keyboard.2 "./copy_qmk_files"

  tmux split-window -h -l 50 -t "$1":keyboard
  tmux send-keys -t "$1":keyboard.3 "cd ~/projects/qmk_firmware" Enter
  tmux send-keys -t "$1":keyboard.3 "make handwired/mrkabuda:ryan:avrdude"

  tmux select-pane -t "$1":keyboard.1
}

alias p.pane="p_pane"
# alias p.plug="p_plug"

# p_plug() {
#   tmux new-window -t "" -n "$1"
#   tmux send-keys -t "":"$1" "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
#   tmux send-keys -t "":"$1" "cd ~/projects/playground" Enter
#   tmux send-keys -t "":"$1" Escape "c" "$1"
# }

p_pane() {
  tmux split-window -v -l 24 -t "$1":"$2" 
  # because specifying pane 2 this needs to be executed in empty terminal
  tmux send-keys -t "$1":"$2".2 "cd ~/projects/playground" Enter
  tmux send-keys -t "$1":"$2".2 "vim.find" Enter
  tmux swap-pane -U
}
