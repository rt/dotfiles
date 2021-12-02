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
  
  tmux select-pane -t $sess:dev.1

  # front-end
  tmux new-window -t $sess -n front-end
  tmux send-keys -t $sess:front-end "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:front-end "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:front-end "ctags_javascript scripts/" Enter
  tmux send-keys -t $sess:front-end "npm run package.watch -- --dsn=qaone --dev=true"

  tmux split-window -v -l 14 -t $sess:front-end
  tmux send-keys -t $sess:front-end.2 "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:front-end.2 "npm test -- --bundle=liquid"

  tmux select-pane -t $sess:front-end.1

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
  tmux send-keys -t $sess:platform "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform "docker compose up"
  
  tmux split-window -v -l 10 -t $sess:platform
  tmux send-keys -t $sess:platform.2 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.2 "docker exec -it devenv_postgres_1 bash"

  tmux split-window -v -l 10 -t $sess:platform
  tmux send-keys -t $sess:platform.3 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.3 "docker exec -it devenv_couchbase_1 bash"

  tmux split-window -v -l 10 -t $sess:platform
  tmux send-keys -t $sess:platform.4 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.4 "docker exec -it devenv_apache_1 bash"

  tmux select-pane -t $sess:platform.1

  # work
  tmux new-window -t $sess -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work" Enter
  tmux send-keys -t $sess:work "vim" Enter

  tmux split-window -v -l 14 -t $sess:work
  tmux send-keys -t $sess:work.2 "cd ~/projects/work" Enter

  tmux select-pane -t $sess:work.1

  #select first
  tmux select-window -t $sess:dev

  tmux -2 attach-session -t $sess

}
