#!/bin/bash

setup_work() {

  sess=${PWD##*/}

  # root
  tmux new-session -s $sess -d -n root
  tmux send-keys -t $sess:root "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:root "cd ~/dev/repos/dev" Enter
  tmux send-keys -t $sess:root "ctags -R --language-force=java -f tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  
  tmux split-window -v -l 14 -t $sess:root
  tmux send-keys -t $sess:root.2 "cd core-webapp/src/main/webapp/resources/$1" Enter
  tmux send-keys -t $sess:root.2 "ctags_javascript scripts/" Enter

  tmux select-pane -t $sess:root.1

  # migrations
  tmux new-window -t $sess -n migrations
  tmux send-keys -t $sess:migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:migrations "cd migrations" Enter
  tmux send-keys -t $sess:migrations "vim" Enter

  tmux split-window -v -l 14 -t $sess:migrations
  tmux send-keys -t $sess:migrations.2 "cd migrations" Enter
  tmux send-keys -t $sess:migrations.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:migrations.1

  ### platform
  tmux new-window -t $sess -n platform
  tmux send-keys -t $sess:platform "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:platform "cd platform" Enter
  tmux send-keys -t $sess:platform "vim" Enter
  
  tmux split-window -v -l 10 -t $sess:platform
  tmux send-keys -t $sess:platform.2 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.2 "docker-compose up"
  
  tmux split-window -v -l 5 -t $sess:platform
  tmux send-keys -t $sess:platform.2 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.2 "docker exec -it devenv_postgres_1 bash"

  tmux split-window -v -l 5 -t $sess:platform
  tmux send-keys -t $sess:platform.2 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.2 "docker exec -it devenv_couchbase_1 bash"

  tmux split-window -v -l 5 -t $sess:platform
  tmux send-keys -t $sess:platform.2 "cd platform/devenv" Enter
  tmux send-keys -t $sess:platform.2 "docker exec -it devenv_apache_1 bash"

  tmux select-pane -t $sess:platform.1

  ### hotelenrichment
  tmux new-window -t $sess -n hotelenrichment
  tmux send-keys -t $sess:hotelenrichment "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:hotelenrichment "cd ~/dev/repos/hotelenrichment" Enter
  tmux send-keys -t $sess:hotelenrichment "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:hotelenrichment
  tmux send-keys -t $sess:hotelenrichment.2 "cd ~/dev/repos/hotelenrichment" Enter

  tmux select-pane -t $sess:hotelenrichment.1

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
  
  #----- dotfiles
  tmux new-window -t $sess -n dotfiles
  tmux send-keys -t $sess:dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $sess:dotfiles "vim" Enter
  
  #tmux split-window -h -l 85 -t $sess:dotfiles
  tmux split-window -v -l 14 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.2 "cd ~/projects/dotfiles" Enter

  tmux split-window -v -l 14 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.3 "cd ~/projects/qmk_firmware" Enter

  tmux select-pane -t $sess:dotfiles.1

  #select first
  tmux select-window -t $sess:root

  tmux -2 attach-session -t $sess


}
