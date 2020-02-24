
setup_work() {

  sess=${PWD##*/}

  # root
  tmux new-session -s $sess -d -n root
  tmux send-keys -t $sess:root "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:root "ctags -R --language-force=java -f tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  
  #tmux split-window -h -l 85 -t $sess:root
  tmux split-window -v -l 12 -t $sess:root

  # shop-fe
  tmux new-window -t $sess -n shop-fe
  tmux send-keys -t $sess:shop-fe "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:shop-fe "cd core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:shop-fe "vim" Enter

  tmux split-window -v -l 12 -t $sess:shop-fe
  tmux send-keys -t $sess:shop-fe.2 "cd core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:shop-fe.2 "ctags_javascript scripts/" Enter
  tmux select-pane -t $sess:shop-fe.1

  # work
  tmux new-window -t $sess -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work" Enter
  tmux send-keys -t $sess:work "vim" Enter

  tmux split-window -v -l 12 -t $sess:work
  tmux send-keys -t $sess:work.2 "cd core-webapp/$1" Enter
  tmux select-pane -t $sess:work.1

  # migrations
  tmux new-window -t $sess -n migrations
  tmux send-keys -t $sess:migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:migrations "cd migrations" Enter
  tmux send-keys -t $sess:migrations "vim" Enter

  tmux split-window -v -l 12 -t $sess:migrations
  tmux send-keys -t $sess:migrations.2 "cd migrations" Enter
  tmux send-keys -t $sess:migrations.2 "ctags -R --language-force=java -f tags src/" Enter
  tmux select-pane -t $sess:migrations.1

  ### system
  tmux new-window -t $sess -n system
  tmux send-keys -t $sess:system "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:system "cd platform/devenv" Enter

  tmux split-window -v -l 12 -t $sess:system
  tmux send-keys -t $sess:system.2 "cd platform/devenv" Enter
  tmux select-pane -t $sess:system.1

  ### deploy
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter

  tmux split-window -v -l 12 -t $sess:deploy
  tmux send-keys -t $sess:deploy.2 "cd ~/dev/repos/deploy" Enter
  tmux select-pane -t $sess:deploy.1


  #select first
  tmux select-window -t $sess:root

  tmux -2 attach-session -t $sess


}
