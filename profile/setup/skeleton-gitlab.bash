#!/bin/bash

alias setup.skeleton.gitlab="setup_skeleton_gitlab"

setup_skeleton_gitlab() {

  sess=skeletongitlab

  #----- skeleton-client-webapp
  tmux new-session -s $sess -d -n skeleton-client-webapp
  tmux send-keys -t $sess:skeleton-client-webapp "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton-client-webapp "cd ~/projects/skeleton-gitlab/skeleton-client-webapp" Enter
  tmux send-keys -t $sess:skeleton-client-webapp "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton-client-webapp
  tmux send-keys -t $sess:skeleton-client-webapp.2 "cd ~/projects/skeleton-gitlab/skeleton-client-webapp" Enter

  tmux select-pane -t $sess:skeleton-client-webapp.1

  #----- skeleton-server-nodejs
  tmux new-window -t $sess -n skeleton-server-nodejs
  tmux send-keys -t $sess:skeleton-server-nodejs "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton-server-nodejs "cd ~/projects/skeleton-gitlab/skeleton-server-nodejs" Enter
  tmux send-keys -t $sess:skeleton-server-nodejs "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton-server-nodejs
  tmux send-keys -t $sess:skeleton-server-nodejs.2 "cd ~/projects/skeleton-gitlab/skeleton-server-nodejs" Enter

  tmux select-pane -t $sess:skeleton-server-nodejs.1

  #----- skeleton-store-client-postgress
  tmux new-window -t $sess -n skeleton-store-client-postgress
  tmux send-keys -t $sess:skeleton-store-client-postgress "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton-store-client-postgress "cd ~/projects/skeleton-gitlab/skeleton-store-client-postgress" Enter
  tmux send-keys -t $sess:skeleton-store-client-postgress "vim" Enter

  tmux split-window -v -l 5 -t $sess:skeleton-store-client-postgress
  tmux send-keys -t $sess:skeleton-store-client-postgress.2 "cd ~/projects/skeleton-gitlab/skeleton-store-client-postgress" Enter

  tmux select-pane -t $sess:skeleton-store-client-postgress.2

  #----- skeleton-store-postgress-create
  tmux new-window -t $sess -n skeleton-store-postgress-create
  tmux send-keys -t $sess:skeleton-store-postgress-create "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton-store-postgress-create "cd ~/projects/skeleton-gitlab/skeleton-store-postgress-create" Enter
  tmux send-keys -t $sess:skeleton-store-postgress-create "vim" Enter

  tmux split-window -v -l 5 -t $sess:skeleton-store-postgress-create
  tmux send-keys -t $sess:skeleton-store-postgress-create.2 "cd ~/projects/skeleton-gitlab/skeleton-store-postgress-create" Enter

  tmux select-pane -t $sess:skeleton-store-postgress-create.2

  #select first window
  tmux select-window -t $sess:skeleton-client-webapp

  tmux -2 attach-session -t $sess

}

