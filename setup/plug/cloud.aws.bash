#!/bin/bash

alias plug.cloud.aws="cloud_aws"

cloud_aws() {
  tmux new-window -t "$1" -n aws
  tmux send-keys -t "$1":aws "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":aws "cd ~/projects/playground-cloud/aws" Enter
  tmux send-keys -t "$1":aws "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":aws
  tmux send-keys -t $1:aws.2 "cd ~/projects/playground-cloud/aws" Enter
  tmux send-keys -t $1:aws.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $1:aws.2 "docker exec -it aws-config bash"

  tmux select-pane -t "$1":aws.1
}
