#!/bin/bash

setup_betsy() {

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

  #----- betsy-spec
  tmux new-window -t $sess -n betsy-spec
  tmux send-keys -t $sess:betsy-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-spec "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-spec
  tmux send-keys -t $sess:betsy-spec.2 "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec.2 "npm run build  ~/projects/betsy/betsy-spec server ~/projects/betsy/betsy-server/"


  tmux split-window -v -l 24 -t $sess:betsy-spec
  tmux send-keys -t $sess:betsy-spec.3 "cd ~/projects/betsy/betsy-spec" Enter
  tmux send-keys -t $sess:betsy-spec.3 "npm run build  ~/projects/betsy/betsy-spec client ~/projects/betsy/betsy-client/"

  tmux select-pane -t $sess:betsy-spec.1

  #----- betsy-server
  tmux new-window -t $sess -n betsy-server
  tmux send-keys -t $sess:betsy-server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-server "cd ~/projects/betsy/betsy-server" Enter
  tmux send-keys -t $sess:betsy-server "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-server
  tmux send-keys -t $sess:betsy-server.2 "cd ~/projects/betsy/betsy-server" Enter
  tmux select-pane -t $sess:betsy-server.1

  #----- betsy-client
  tmux new-window -t $sess -n betsy-client
  tmux send-keys -t $sess:betsy-client "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-client "cd ~/projects/betsy/betsy-client" Enter
  tmux send-keys -t $sess:betsy-client "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-client
  tmux send-keys -t $sess:betsy-client.2 "cd ~/projects/betsy/betsy-client" Enter
  tmux select-pane -t $sess:betsy-client.1

  #----- betsy-old
  tmux new-window -t $sess -n betsy-old
  tmux send-keys -t $sess:betsy-old "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy-old "cd ~/projects/betsy/betsy-old" Enter
  tmux send-keys -t $sess:betsy-old "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy-old
  tmux send-keys -t $sess:betsy-old.2 "cd ~/projects/betsy/betsy-old" Enter
  tmux select-pane -t $sess:betsy-old.1

}

