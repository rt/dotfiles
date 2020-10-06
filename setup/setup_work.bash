#!/bin/bash

setup_work() {

  sess=${PWD##*/}

  # root
  tmux new-session -s $sess -d -n root
  tmux send-keys -t $sess:root "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:root "ctags -R --language-force=java -f tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  
  tmux select-pane -t $sess:root.1

  # shop-fe
  tmux new-window -t $sess -n shop-fe
  tmux send-keys -t $sess:shop-fe.1 "cd core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:shop-fe.1 "ctags_javascript scripts/" Enter

  tmux select-pane -t $sess:shop-fe.1

  # devops
  tmux new-window -t $sess -n devops
  tmux send-keys -t $sess:devops "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:devops "cd ~/dev/repos/devops" Enter
  tmux send-keys -t $sess:devops "vim" Enter

  tmux select-pane -t $sess:devops.1

  # work
  tmux new-window -t $sess -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work/" Enter
  tmux send-keys -t $sess:work "vim" Enter

  tmux select-pane -t $sess:work.1

  # migrations
  tmux new-window -t $sess -n migrations
  tmux send-keys -t $sess:migrations.1 "cd migrations" Enter
  tmux send-keys -t $sess:migrations.1 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:migrations.1

  ### system
  tmux new-window -t $sess -n system
  tmux send-keys -t $sess:system "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:system "cd platform/devenv" Enter
  tmux send-keys -t $sess:system "docker-compose up"

  ### deploy
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter
  
  tmux select-pane -t $sess:deploy.1

  ### enrichment
  tmux new-window -t $sess -n enrichment
  tmux send-keys -t $sess:enrichment "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:enrichment "cd ~/dev/repos/enrichment" Enter

  tmux select-pane -t $sess:enrichment.1


  #select first
  tmux select-window -t $sess:root

  tmux -2 attach-session -t $sess


}
