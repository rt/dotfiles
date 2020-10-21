#!/bin/bash

setup_work_devops() {

  sess=ops

  # devops
  tmux new-session -s $sess -d -n devops
  tmux send-keys -t $sess:devops "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:devops "cd ~/dev/repos/devops" Enter
  tmux send-keys -t $sess:devops "vim" Enter

  tmux split-window -v -l 5 -t $sess:devops
  tmux send-keys -t $sess:devops.2 "cd ~/dev/repos/devops" Enter

  tmux select-pane -t $sess:devops.1

  ### work
  tmux new-window -t $sess -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work" Enter
  tmux send-keys -t $sess:work "vim" Enter
  
  tmux split-window -v -l 5 -t $sess:work
  tmux send-keys -t $sess:work.2 "cd ~/projects/work" Enter

  tmux select-pane -t $sess:work.1

  ### dev (just for reference)
  tmux new-window -t $sess -n dev
  tmux send-keys -t $sess:dev "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dev "cd ~/dev/repos/dev" Enter
  tmux send-keys -t $sess:dev "vim" Enter
  
  tmux select-pane -t $sess:dev.1

  ### deploy (just for reference)
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter
  tmux send-keys -t $sess:deploy "vim" Enter
  
  tmux select-pane -t $sess:deploy.1


  #select first
  tmux select-window -t $sess:devops

  tmux -2 attach-session -t $sess


}
