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

  #----- clib
  tmux new-window -t $sess -n clib
  tmux send-keys -t $sess:clib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clib "cd ~/projects/skeleton/component-library" Enter
  tmux send-keys -t $sess:clib "vim" Enter

  tmux split-window -v -l 24 -t $sess:clib
  tmux send-keys -t $sess:clib.2 "cd ~/projects/skeleton/component-library" Enter

  tmux select-pane -t $sess:clib.1

  #----- ecom-spec
  tmux new-window -t $sess -n ecom-spec
  tmux send-keys -t $sess:ecom-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-spec "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:ecom-spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:ecom-spec
  tmux send-keys -t $sess:ecom-spec.2 "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:ecom-spec.2 "npm run build  ~/projects/ecom/ecom-spec server ~/projects/ecom/ecom-server/"


  tmux split-window -v -l 24 -t $sess:ecom-spec
  tmux send-keys -t $sess:ecom-spec.3 "cd ~/projects/ecom/ecom-spec" Enter
  tmux send-keys -t $sess:ecom-spec.3 "npm run build  ~/projects/ecom/ecom-spec client ~/projects/ecom/ecom-client/"

  tmux select-pane -t $sess:ecom-spec.1

  #----- ecom-server
  tmux new-window -t $sess -n ecom-server
  tmux send-keys -t $sess:ecom-server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-server "cd ~/projects/ecom/ecom-server" Enter
  tmux send-keys -t $sess:ecom-server "vim" Enter

  tmux split-window -v -l 24 -t $sess:ecom-server
  tmux send-keys -t $sess:ecom-server.2 "cd ~/projects/ecom/ecom-server" Enter

  tmux select-pane -t $sess:ecom-server.1

  #----- ecom-client
  tmux new-window -t $sess -n ecom-client
  tmux send-keys -t $sess:ecom-client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ecom-client "cd ~/projects/ecom/ecom-client" Enter
  tmux send-keys -t $sess:ecom-client "vim" Enter

  tmux split-window -v -l 24 -t $sess:ecom-client
  tmux send-keys -t $sess:ecom-client.2 "cd ~/projects/ecom/ecom-client" Enter

  tmux select-pane -t $sess:ecom-client.1

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

