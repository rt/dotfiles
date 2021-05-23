#!/bin/bash

alias setup.home="setup_other"

setup_other() {

  sess=other

  #----- liquid
  tmux new-session -s $sess -d -n liquid
  tmux new-window -t $sess -n liquid
  tmux send-keys -t $sess:liquid "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:liquid "cd ~/projects/kabuda/kabuda-liquid" Enter
  tmux send-keys -t $sess:liquid "vim" Enter

  tmux split-window -v -l 24 -t $sess:liquid
  tmux send-keys -t $sess:liquid.2 "cd ~/projects/kabuda/kabuda-liquid" Enter
  tmux send-keys -t $sess:liquid.2 "npm test" Enter
  tmux select-pane -t $sess:liquid.1

  #----- yoteam
  tmux new-window -t $sess -n yoteam
  tmux send-keys -t $sess:yoteam "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:yoteam "cd ~/projects/yoteam" Enter
  tmux send-keys -t $sess:yoteam "vim" Enter

  tmux split-window -v -l 24 -t $sess:yoteam
  tmux send-keys -t $sess:yoteam.2 "cd ~/projects/yoteam" Enter
  tmux select-pane -t $sess:yoteam.1
  
  #select first
  tmux select-window -t $sess:liquid

  tmux -2 attach-session -t $sess

}

