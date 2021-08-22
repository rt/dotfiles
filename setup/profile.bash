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

  #----- skeleton
  tmux new-window -t $sess -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton-spec" Enter

  tmux select-pane -t $sess:skeleton.1

  #----- gcloud
  tmux new-window -t $sess -n gcloud
  tmux send-keys -t $sess:gcloud "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:gcloud "cd ~/projects/dotfiles/quick-reference/gcloud/" Enter
  tmux send-keys -t $sess:gcloud "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:gcloud
  tmux send-keys -t $sess:gcloud.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $sess:gcloud.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t $sess:gcloud.1

  #----- aws
  tmux new-window -t $sess -n aws
  tmux send-keys -t $sess:aws "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:aws "cd ~/projects/dotfiles/quick-reference/aws/" Enter
  tmux send-keys -t $sess:aws "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:aws
  tmux send-keys -t $sess:aws.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $sess:aws.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t $sess:aws.1

  #----- oci
  tmux new-window -t $sess -n oci
  tmux send-keys -t $sess:oci "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:oci "cd ~/projects/dotfiles/quick-reference/oci/" Enter
  tmux send-keys -t $sess:oci "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:oci
  tmux send-keys -t $sess:oci.2 "echo 'You must pull and run the image, once you have it you don't want to delete it because you are logged in.'" Enter
  tmux send-keys -t $sess:oci.2 "docker exec -it gcloud-config bash"

  tmux select-pane -t $sess:oci.1

  #select first
  tmux select-window -t $sess:dotfiles

  tmux -2 attach-session -t $sess

}

