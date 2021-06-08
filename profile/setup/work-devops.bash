#!/bin/bash

alias setup.work.devops="setup_work_devops"

setup_work_devops() {

  # sess=${PWD##*/}
  sess=workdevops

  ### devops
  tmux new-window -s $sess -d -n devops
  tmux send-keys -t $sess:devops "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:devops "cd ~/dev/repos/devops" Enter
  tmux send-keys -t $sess:devops "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:devops
  tmux send-keys -t $sess:devops.2 "cd ~/dev/repos/devops" Enter

  tmux select-pane -t $sess:devops.1

  ### deploy (just for reference)
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter
  tmux send-keys -t $sess:deploy "vim" Enter

  ### docker images ...

  #select first
  tmux select-window -t $sess:devops

  tmux -2 attach-session -t $sess

}
