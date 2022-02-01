#!/bin/bash

alias plug.project.component-library="project_component-library"

project_component-library() {
  tmux new-window -t "$1" -n component-library
  tmux send-keys -t "$1":component-library "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":component-library "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t "$1":component-library "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":component-library
  tmux send-keys -t "$1":component-library.2 "cd ~/projects/skeleton/component-library" Enter

  tmux select-pane -t "$1":component-library.1
}
  
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

alias plug.project.liquid="project_liquid"

project_liquid() {
  tmux new-window -t "$1" -n liquid
  tmux send-keys -t "$1":liquid "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":liquid "cd ~/projects/liquid" Enter
  tmux send-keys -t "$1":liquid "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":liquid
  tmux send-keys -t "$1":liquid.2 "cd ~/projects/liquid" Enter

  tmux select-pane -t "$1":liquid.1
}

alias plug.project.remira="project_remira"

project_remira() {
  tmux new-window -t "$1" -n remira
  tmux send-keys -t "$1":remira "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":remira "cd ~/projects/remira" Enter
  tmux send-keys -t "$1":remira "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":remira
  tmux send-keys -t "$1":remira.2 "cd ~/projects/remira" Enter

  tmux select-pane -t "$1":remira.1
}

alias plug.project.skeleton="project_skeleton"

project_skeleton() {
  tmux new-window -t "$1" -n skeleton
  tmux send-keys -t "$1":skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":skeleton "cd ~/projects/skeleton/skeleton" Enter
  tmux send-keys -t "$1":skeleton "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":skeleton
  tmux send-keys -t "$1":skeleton.2 "cd ~/projects/skeleton/skeleton" Enter

  tmux select-pane -t "$1":skeleton.1
}

alias plug.project.yoteam="project_yoteam"

project_yoteam() {
  tmux new-window -t "$1" -n yoteam
  tmux send-keys -t "$1":yoteam "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":yoteam "cd ~/projects/yoteam" Enter
  tmux send-keys -t "$1":yoteam "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":yoteam
  tmux send-keys -t "$1":yoteam.2 "cd ~/projects/yoteam" Enter

  tmux select-pane -t "$1":yoteam.1
}
