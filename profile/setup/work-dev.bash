#!/bin/bash

alias setup.work.dev="setup_work_dev"

setup_work_dev() {

  # sess=${PWD##*/}
  sess=workdev

  # dev
  tmux new-session -s $sess -d -n dev
  tmux send-keys -t $sess:dev "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dev "cd ~/dev/repos/dev" Enter
  tmux send-keys -t $sess:dev "ctags -R --language-force=java -f .tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  tmux send-keys -t $sess:dev "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:dev
  tmux send-keys -t $sess:dev.2 "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:dev.2 "ctags_javascript scripts/" Enter

  tmux select-pane -t $sess:dev.1

  # migrations
  tmux new-window -t $sess -n migrations
  tmux send-keys -t $sess:migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:migrations "cd migrations" Enter
  tmux send-keys -t $sess:migrations "vim" Enter

  tmux split-window -v -l 14 -t $sess:migrations
  tmux send-keys -t $sess:migrations.2 "cd migrations" Enter
  tmux send-keys -t $sess:migrations.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:migrations.1

  # platform
  tmux new-window -t $sess -n platform
  tmux send-keys -t $sess:platform "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:platform "cd platform" Enter
  tmux send-keys -t $sess:platform "vim" Enter
  
  tmux split-window -v -l 10 -t $sess:platform
  tmux send-keys -t $sess:platform.2 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.2 "docker compose up"
  
  tmux split-window -v -l 5 -t $sess:platform
  tmux send-keys -t $sess:platform.3 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.3 "docker exec -it devenv_postgres_1 bash"

  tmux split-window -v -l 5 -t $sess:platform
  tmux send-keys -t $sess:platform.4 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.4 "docker exec -it devenv_couchbase_1 bash"

  tmux split-window -v -l 5 -t $sess:platform
  tmux send-keys -t $sess:platform.5 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.5 "docker exec -it devenv_apache_1 bash"

  tmux select-pane -t $sess:platform.1

  #select first
  tmux select-window -t $sess:dev

  tmux -2 attach-session -t $sess

}
