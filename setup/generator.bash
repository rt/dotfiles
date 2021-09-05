#!/bin/bash

alias setup.generator="setup_generator"

setup_generator() {

  sess=generator

  #----- skeleton
  tmux new-session -s $sess -d -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton" Enter

  tmux select-pane -t $sess:skeleton.1

  #----- component-library
  tmux new-window -t $sess -n component-library
  tmux send-keys -t $sess:component-library "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:component-library "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:component-library "vim" Enter

  tmux split-window -v -l 24 -t $sess:component-library
  tmux send-keys -t $sess:component-library.2 "cd ~/projects/skeleton/component-library" Enter

  tmux select-pane -t $sess:component-library.1

  #----- skeleton-spec
  tmux new-window -t $sess -n skeleton-spec
  tmux send-keys -t $sess:skeleton-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton-spec "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:skeleton-spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton-spec
  tmux send-keys -t $sess:skeleton-spec.2 "cd ~/projects/skeleton/skeleton-spec" Enter

  tmux select-pane -t $sess:skeleton-spec.1

  #select first window
  tmux select-window -t $sess:skeleton

  tmux -2 attach-session -t $sess

}


