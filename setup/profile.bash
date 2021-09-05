#!/bin/bash

alias setup.profile="setup_profile"

setup_profile() {

  sess=profile

  #----- dotfiles
  tmux new-session -s $sess -d -n dotfiles
  tmux send-keys -t $sess:dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $sess:dotfiles "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.2 "cd ~/projects/dotfiles/" Enter
  tmux send-keys -t $sess:dotfiles "./bootstrap rtsunoda"

  tmux select-pane -t $sess:dotfiles.1

  #----- keyboard
  tmux new-window -t $sess -n keyboard
  tmux send-keys -t $sess:keyboard "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:keyboard "cd ~/projects/keyboard" Enter
  tmux send-keys -t $sess:keyboard "vim" Enter

  tmux split-window -v -l 24 -t $sess:keyboard
  tmux send-keys -t $sess:keyboard.2 "cd ~/projects/keyboard/" Enter
  tmux send-keys -t $sess:keyboard.2 "./copy_qmk_files"

  tmux split-window -h -l 50 -t $sess:keyboard
  tmux send-keys -t $sess:keyboard.3 "cd ~/projects/qmk_firmware" Enter
  tmux send-keys -t $sess:keyboard.3 "make handwired/mrkabuda:ryan:avrdude"

  tmux select-pane -t $sess:keyboard.1

  #select first
  tmux select-window -t $sess:dotfiles

  tmux -2 attach-session -t $sess

}

