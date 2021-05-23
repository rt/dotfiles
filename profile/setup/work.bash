#!/bin/bash

alias setup.work="setup_work"

setup_work() {

  # sess=${PWD##*/}
  sess=work

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

  # dev1
  tmux new-window -t $sess -n dev1
  tmux send-keys -t $sess:dev1 "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dev1 "cd ~/dev/repos/dev1" Enter
  tmux send-keys -t $sess:dev1 "ctags -R --language-force=java -f .tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  tmux send-keys -t $sess:dev1 "vim" Enter

  tmux split-window -v -l 14 -t $sess:dev1
  tmux send-keys -t $sess:dev1.2 "cd ~/dev/repos/dev1/core-webapp/src/main/webapp/resources/shopping" Enter
  tmux send-keys -t $sess:dev1.2 "ctags_javascript scripts/" Enter

  tmux select-pane -t $sess:dev1.1

  # migrations
  tmux new-window -t $sess -n migrations
  tmux send-keys -t $sess:migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:migrations "cd migrations" Enter
  tmux send-keys -t $sess:migrations "vim" Enter

  tmux split-window -v -l 14 -t $sess:migrations
  tmux send-keys -t $sess:migrations.2 "cd migrations" Enter
  tmux send-keys -t $sess:migrations.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:migrations.1

  # automation
  tmux new-window -t $sess -n automation
  tmux send-keys -t $sess:automation "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:automation "cd test-automation" Enter
  tmux send-keys -t $sess:automation "vim src/test/resources/rtsunoda.properties"

  tmux split-window -v -l 14 -t $sess:automation
  tmux send-keys -t $sess:automation.2 "cd test-automation" Enter
  tmux send-keys -t $sess:automation.2 "mvn -P automation -Dit.test=SomeTestIT verify"
  # tmux send-keys -t $sess:automation "mvn verify -P automation -Dtest.groups=some-group"

  tmux select-pane -t $sess:automation.1

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

  ### devops
  tmux new-window -t $sess -n ops
  tmux send-keys -t $sess:ops "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ops "cd ~/dev/repos/devops" Enter
  tmux send-keys -t $sess:ops "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:ops
  tmux send-keys -t $sess:ops.2 "cd ~/dev/repos/devops" Enter

  tmux select-pane -t $sess:ops.1

  ### deploy (just for reference)
  tmux new-window -t $sess -n deploy
  tmux send-keys -t $sess:deploy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:deploy "cd ~/dev/repos/deploy" Enter
  tmux send-keys -t $sess:deploy "vim" Enter
  
  tmux select-pane -t $sess:deploy.1

  ### work
  tmux new-window -t $sess -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work" Enter
  tmux send-keys -t $sess:work "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:work
  tmux send-keys -t $sess:work.2 "cd ~/projects/work" Enter

  tmux split-window -v -l 14 -t $sess:work
  tmux send-keys -t $sess:work.3 "cd ~/projects/work" Enter

  tmux select-pane -t $sess:work.1
  
  #select first
  tmux select-window -t $sess:dev

  tmux -2 attach-session -t $sess

}
