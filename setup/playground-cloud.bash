#!/bin/bash

alias setup.playground.cloud="setup_playground_cloud"

setup_playground_cloud() {

  sess=playgroundcloud

  #----- top
  tmux new-session -s $sess -d -n top
  tmux send-keys -t $sess:top "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:top "cd ~/projects/playground-cloud/" Enter
  tmux send-keys -t $sess:top "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:top
  tmux send-keys -t $sess:top.2 "cd ~/projects/playground-cloud/" Enter

  tmux select-pane -t $sess:top.1

  #----- gcloud
  tmux new-window -t $sess -n gcloud
  tmux send-keys -t $sess:gcloud "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:gcloud "cd ~/projects/playground-cloud/gcloud/" Enter
  tmux send-keys -t $sess:gcloud "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:gcloud
  tmux send-keys -t $sess:gcloud.2 "cd ~/projects/playground-cloud/gcloud/" Enter
  tmux send-keys -t $sess:gcloud.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $sess:gcloud.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t $sess:aws.1

  #----- aws
  tmux new-window -t $sess -n aws
  tmux send-keys -t $sess:aws "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:aws "cd ~/projects/playground-cloud/aws/" Enter
  tmux send-keys -t $sess:aws "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:aws
  tmux send-keys -t $sess:aws.2 "cd ~/projects/playground-cloud/aws/" Enter
  tmux send-keys -t $sess:aws.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $sess:aws.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t $sess:aws.1

  #----- oci
  tmux new-window -t $sess -n oci
  tmux send-keys -t $sess:oci "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:oci "cd ~/projects/playground-cloud/oci/" Enter
  tmux send-keys -t $sess:oci "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:oci
  tmux send-keys -t $sess:oci.2 "cd ~/projects/playground-cloud/oci/" Enter
  tmux send-keys -t $sess:oci.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $sess:oci.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t $sess:oci.1
  
  #----- gitlab-k8s-cicd
  tmux new-window -t $sess -n gitlab-k8s-cicd
  tmux send-keys -t $sess:gitlab-k8s-cicd "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:gitlab-k8s-cicd "cd ~/projects/gitlab-k8s-cicd/" Enter
  tmux send-keys -t $sess:gitlab-k8s-cicd "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:gitlab-k8s-cicd
  tmux send-keys -t $sess:gitlab-k8s-cicd.2 "cd ~/projects/gitlab-k8s-cicd/" Enter

  tmux select-pane -t $sess:gitlab-k8s-cicd.1


  #select first
  tmux select-window -t $sess:top

  tmux -2 attach-session -t $sess

}

