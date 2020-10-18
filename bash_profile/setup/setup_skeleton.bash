#!/bin/bash

setup_skeleton() {

  sess=forward

  #----- skeleton
  tmux new-session -s $sess -d -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton/skeleton-spec" Enter

  #----- dotfiles
  tmux new-window -t $sess -n dotfiles
  tmux send-keys -t $sess:dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $sess:dotfiles "vim" Enter
  
  #tmux split-window -h -l 85 -t $sess:dotfiles
  tmux split-window -v -l 24 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.2 "cd ~/projects/dotfiles" Enter

  tmux split-window -v -l 24 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.3 "cd ~/projects/qmk_firmware" Enter

  tmux select-pane -t $sess:dotfiles.1

  #----- liquid
  tmux new-window -t $sess -n liquid
  tmux send-keys -t $sess:liquid "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:liquid "cd ~/projects/kabuda/kabuda-liquid" Enter
  tmux send-keys -t $sess:liquid "vim" Enter

  tmux split-window -v -l 24 -t $sess:liquid
  tmux send-keys -t $sess:liquid.2 "cd ~/projects/kabuda/kabuda-liquid" Enter
  tmux send-keys -t $sess:liquid.2 "npm test" Enter
  tmux select-pane -t $sess:liquid.1

  #----- clib
  tmux new-window -t $sess -n clib
  tmux send-keys -t $sess:clib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clib "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:clib "vim" Enter

  tmux split-window -v -l 24 -t $sess:clib
  tmux send-keys -t $sess:clib.2 "cd ~/projects/skeleton/component-library" Enter
  tmux select-pane -t $sess:clib.1

  #----- yoteam
  tmux new-window -t $sess -n yoteam
  tmux send-keys -t $sess:yoteam "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:yoteam "cd ~/projects/yoteam" Enter
  tmux send-keys -t $sess:yoteam "vim" Enter

  tmux split-window -v -l 24 -t $sess:yoteam
  tmux send-keys -t $sess:yoteam.2 "cd ~/projects/yoteam" Enter
  tmux select-pane -t $sess:yoteam.1
  
  #----- playground
  tmux new-window -t $sess -n playground
  tmux send-keys -t $sess:playground "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:playground "cd ~/projects/playground" Enter
  tmux send-keys -t $sess:playground "vim" Enter

  tmux split-window -v -l 24 -t $sess:playground
  tmux send-keys -t $sess:playground.2 "cd ~/projects/playground" Enter
  tmux select-pane -t $sess:playground.1


  #select first
  tmux select-window -t $sess:skeleton

  tmux -2 attach-session -t $sess

}

