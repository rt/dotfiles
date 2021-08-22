#!/bin/bash

alias setup.sa="setup_sa"

setup_sa() {

  sess=sa

  #----- frontend
  tmux new-session -s $sess -d -n frontend
  tmux send-keys -t $sess:frontend "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:frontend "cd ~/projects/sa/sa-frontend" Enter
  tmux send-keys -t $sess:frontend "vim" Enter

  tmux split-window -v -l 24 -t $sess:frontend
  tmux send-keys -t $sess:frontend.2 "cd ~/projects/sa/sa-frontend" Enter

  tmux select-pane -t $sess:frontend.1

  #----- webapp
  tmux new-window -t $sess -n webapp
  tmux send-keys -t $sess:webapp "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:webapp "cd ~/projects/sa/sa-webapp" Enter
  tmux send-keys -t $sess:webapp "vim" Enter

  tmux split-window -v -l 24 -t $sess:webapp
  tmux send-keys -t $sess:webapp.2 "cd ~/projects/skeleton/skeleton-webapp" Enter
  tmux send-keys -t $sess:webapp.2 "npm run build ~/projects/sa/sa-webapp server ~/projects/sa/sa-server/"

  tmux select-pane -t $sess:webapp.1

  #----- logic
  tmux new-window -t $sess -n logic
  tmux send-keys -t $sess:logic "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:logic "cd ~/projects/sa/sa-logic" Enter
  tmux send-keys -t $sess:logic "vim" Enter

  tmux split-window -v -l 5 -t $sess:logic
  tmux send-keys -t $sess:logic.2 "cd ~/projects/sa/sa-logic" Enter
  tmux send-keys -t $sess:logic.2 "./gradlew build"

  tmux select-pane -t $sess:logic.2

  #select first window
  tmux select-window -t $sess:frontend

  tmux -2 attach-session -t $sess

}

