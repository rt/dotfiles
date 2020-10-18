#!/bin/bash

setup_work_devops() {

  sess=devops

  # devops
  tmux new-session -s $sess -d -n devops
  tmux send-keys -t $sess:devops "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:devops "cd ~/dev/repos/devops" Enter

  tmux select-pane -t $sess:devops.1

  ### deploy
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter
  
  tmux select-pane -t $sess:deploy.1


  #select first
  tmux select-window -t $sess:devops

  tmux -2 attach-session -t $sess


}
