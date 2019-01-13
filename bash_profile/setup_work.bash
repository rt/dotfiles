
setup_work() {

  sess=${PWD##*/}

  # root
  tmux -S /tmp/pair new-session -s $sess -d -n root
  tmux -S /tmp/pair send-keys -t $sess:root "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:root "ctags -R --language-force=java -f tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  
  #tmux -S /tmp/pair split-window -h -l 85 -t $sess:root
  tmux -S /tmp/pair split-window -v -l 12 -t $sess:root

  # shop-fe
  tmux -S /tmp/pair new-window -t $sess -n shop-fe
  tmux -S /tmp/pair send-keys -t $sess:shop-fe "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:shop-fe "cd core-webapp/src/main/webapp/resources/$1" Enter
  tmux -S /tmp/pair send-keys -t $sess:shop-fe "vim" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:shop-fe
  tmux -S /tmp/pair send-keys -t $sess:shop-fe.2 "cd core-webapp/src/main/webapp/resources/$1" Enter
  tmux -S /tmp/pair send-keys -t $sess:shop-fe.2 "ctags_javascript scripts/" Enter
  tmux -S /tmp/pair select-pane -t $sess:shop-fe.1

  # shop-be
  tmux -S /tmp/pair new-window -t $sess -n shop-be
  tmux -S /tmp/pair send-keys -t $sess:shop-be "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:shop-be "cd webapp-spring/src/main/java/com/switchfly/apps/shopping/$1" Enter
  tmux -S /tmp/pair send-keys -t $sess:shop-be "vim" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:shop-be
  tmux -S /tmp/pair send-keys -t $sess:shop-be.2 "cd core-webapp/$1" Enter
  tmux -S /tmp/pair select-pane -t $sess:shop-be.1

  # e2e
  tmux -S /tmp/pair new-window -t $sess -n e2e
  tmux -S /tmp/pair send-keys -t $sess:e2e "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:e2e "cd test-automation" Enter
  tmux -S /tmp/pair send-keys -t $sess:e2e "vim pom.xml" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:test-automation
  tmux -S /tmp/pair send-keys -t $sess:e2e.2 "cd test-automation" Enter
  tmux -S /tmp/pair send-keys -t $sess:e2e.2 "ctags -R --language-force=java -f tags src/" Enter
  tmux -S /tmp/pair select-pane -t $sess:e2e.1

  # migrations
  tmux -S /tmp/pair new-window -t $sess -n migrations
  tmux -S /tmp/pair send-keys -t $sess:migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:migrations "cd migrations" Enter
  tmux -S /tmp/pair send-keys -t $sess:migrations "vim" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:migrations
  tmux -S /tmp/pair send-keys -t $sess:migrations.2 "cd migrations" Enter
  tmux -S /tmp/pair send-keys -t $sess:migrations.2 "ctags -R --language-force=java -f tags src/" Enter
  tmux -S /tmp/pair select-pane -t $sess:migrations.1

  ### system
  tmux -S /tmp/pair new-window -t $sess -n system
  tmux -S /tmp/pair send-keys -t $sess:system "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:system "cd platform/devenv" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:system
  tmux -S /tmp/pair send-keys -t $sess:system.2 "cd platform/devenv" Enter
  tmux -S /tmp/pair select-pane -t $sess:system.1

  ### deploy
  tmux -S /tmp/pair new-window -t $sess -n deploy
  tmux -S /tmp/pair send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:deploy
  tmux -S /tmp/pair send-keys -t $sess:deploy.2 "cd ~/dev/repos/deploy" Enter
  tmux -S /tmp/pair select-pane -t $sess:deploy.1


  #select first
  tmux -S /tmp/pair select-window -t $sess:root

  tmux -S /tmp/pair -2 attach-session -t $sess


}
