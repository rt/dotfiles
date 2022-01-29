#!/bin/bash

alias plug.cloud.gcloud="cloud_gcloud"

cloud_gcloud() {
  tmux new-window -t "$1" -n gcloud
  tmux send-keys -t "$1":gcloud "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":gcloud "cd ~/projects/playground-cloud/gcloud" Enter
  tmux send-keys -t "$1":gcloud "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":gcloud
  tmux send-keys -t $1:gcloud.2 "cd ~/projects/playground-cloud/gcloud" Enter
  tmux send-keys -t $1:gcloud.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $1:gcloud.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t "$1":gcloud.1
}
