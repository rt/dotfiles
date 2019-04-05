

setup_skeleton() {

  sess=forward

  #----- skeleton
  tmux new-session -s $sess -d -n skeleton
  tmux send-keys -t $sess:skeleton "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton "cd ~/projects/skeleton" Enter
  tmux send-keys -t $sess:skeleton "vim" Enter

  tmux split-window -v -l 24 -t $sess:skeleton
  tmux send-keys -t $sess:skeleton.2 "cd ~/projects/skeleton" Enter

  #----- yoteam
  tmux new-window -t $sess -n yoteam
  tmux send-keys -t $sess:yoteam "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:yoteam "cd ~/projects/yoteam" Enter
  tmux send-keys -t $sess:yoteam "vim" Enter

  tmux split-window -v -l 24 -t $sess:yoteam
  tmux send-keys -t $sess:yoteam.2 "cd ~/projects/yoteam" Enter
  tmux select-pane -t $sess:yoteam.1
  
  #----- dotfiles
  tmux new-window -t $sess -n dotfiles
  tmux send-keys -t $sess:dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $sess:dotfiles "vim" Enter
  
  #tmux split-window -h -l 85 -t $sess:dotfiles
  tmux split-window -v -l 24 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.2 "cd ~/projects/dotfiles" Enter
  tmux select-pane -t $sess:dotfiles.1

  #----- liquid
  tmux new-window -t $sess -n liquid
  tmux send-keys -t $sess:liquid "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:liquid "cd ~/projects/kabuda-liquid" Enter
  tmux send-keys -t $sess:liquid "vim" Enter

  tmux split-window -v -l 24 -t $sess:liquid
  tmux send-keys -t $sess:liquid.2 "cd ~/projects/kabuda-liquid" Enter
  tmux send-keys -t $sess:liquid.2 "npm test" Enter
  tmux select-pane -t $sess:liquid.1

  #----- qmk
  tmux new-window -t $sess -n qmk
  tmux send-keys -t $sess:qmk "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:qmk "cd ~/projects/qmk_firmware" Enter
  # tmux send-keys -t $sess:qmk "vim -S ~/projects/dotfiles/vim-sessions/qmk_firmware.vim" Enter
  tmux send-keys -t $sess:qmk "vim users/ryan/ryan.h users/ryan/ryan.c" Enter

  tmux split-window -v -l 24 -t $sess:qmk
  tmux send-keys -t $sess:qmk.2 "cd ~/projects/qmk_firmware" Enter
  tmux select-pane -t $sess:qmk.1

  #----- work
  tmux new-window -t $sess -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work" Enter
  tmux send-keys -t $sess:work "vim" Enter

  tmux split-window -v -l 24 -t $sess:work
  tmux send-keys -t $sess:work.2 "cd ~/projects/work" Enter
  tmux select-pane -t $sess:work.1

  #----- clib
  tmux new-window -t $sess -n clib
  tmux send-keys -t $sess:clib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clib "cd ~/projects/kabuda-component-library" Enter
  tmux send-keys -t $sess:clib "vim" Enter

  tmux split-window -v -l 24 -t $sess:clib
  tmux send-keys -t $sess:clib.2 "cd ~/projects/kabuda-component-library" Enter
  tmux select-pane -t $sess:clib.1

  #----- betsy
  tmux new-window -t $sess -n betsy
  tmux send-keys -t $sess:betsy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:betsy "cd ~/projects/betsy" Enter
  tmux send-keys -t $sess:betsy "vim" Enter

  tmux split-window -v -l 24 -t $sess:betsy
  tmux send-keys -t $sess:betsy.2 "cd ~/projects/betsy" Enter
  tmux select-pane -t $sess:betsy.1

  #----- layout
  tmux new-window -t $sess -n layout
  tmux send-keys -t $sess:layout "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:layout "cd ~/projects/layout-analyzer" Enter
  tmux send-keys -t $sess:layout "vim" Enter

  tmux split-window -v -l 24 -t $sess:layout
  tmux send-keys -t $sess:layout.2 "cd ~/projects/layout-analyzer" Enter
  tmux select-pane -t $sess:layout.1



  #select first
  tmux select-window -t $sess:skeleton

  tmux -2 attach-session -t $sess

}
