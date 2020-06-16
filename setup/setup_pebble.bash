#!/bin/bash

setup_pebble() {

  sess=pebble

  #if pairing
  #cp ~/.vimrc /home/guest/

  #need to put -S /tmp/pair for all entries
  #tmux -S /tmp/pair new-session -s $sess -d -n lib
  tmux new-session -s $sess -d -n lib
  tmux send-keys -t $sess:lib "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:lib "cd ~/projects/pebble" Enter
  tmux send-keys -t $sess:lib "vim" Enter

  tmux split-window -v -l 5 -t $sess:lib
  tmux send-keys -t $sess:lib.2 "cd ~/projects/pebble" Enter
  tmux send-keys -t $sess:lib.2 "grunt karma" Enter
  #tmux split-window -h -p 70 -t $sess:lib.3
  #tmux send-keys -t $sess:lib.4 "cd ~/projects/pebble" Enter
  #tmux send-keys -t $sess:lib.4 "grunt watch:compile" Enter
  #tmux split-window -h -p 50 -t $sess:lib.4 
  #tmux send-keys -t $sess:lib.5 "cd ~/projects/pebble" Enter
  #tmux send-keys -t $sess:lib.5 "grunt watch:jshint" Enter
  tmux select-pane -t $sess:lib.1

  tmux new-window -t $sess -n remira
  tmux send-keys -t $sess:remira "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:remira "cd ~/projects/remira" Enter
  tmux send-keys -t $sess:remira "vim" Enter

  tmux new-window -t $sess -n wiki
  tmux send-keys -t $sess:wiki "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:wiki "cd ~/projects/pebble/wiki" Enter
  tmux send-keys -t $sess:wiki "vim" Enter

  tmux new-window -t $sess -n dev
  tmux send-keys -t $sess:dev "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dev "cd ~/project/pebble-dev" Enter
  tmux send-keys -t $sess:dev "vim" Enter
  tmux split-window -v -l 5 -t $sess:dev
  tmux send-keys -t $sess:dev.2 "cd ~/projects/pebble-dev" Enter
  tmux send-keys -t $sess:dev.2 "node app.js" Enter
  tmux split-window -h -p 60 -t $sess:dev.2
  tmux send-keys -t $sess:dev.3 "cd ~/projects/pebble-dev/automation" Enter
  tmux send-keys -t $sess:dev.3 "mocha mocha-test.js" Enter
  tmux split-window -h -p 60 -t $sess:dev.3
  tmux send-keys -t $sess:dev.4 "cd ~/projects/pebble-dev/automation" Enter
  tmux send-keys -t $sess:dev.4 "java -jar selenium-server-standalone-2.42.0.jar" Enter
  tmux select-pane -t $sess:dev.1

  tmux new-window -t $sess -n appstack
  tmux send-keys -t $sess:appstack "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:appstack "cd ~/projects/appstack" Enter
  tmux send-keys -t $sess:appstack "vim" Enter

  tmux new-window -t $sess -n dotfiles
  tmux send-keys -t $sess:dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $sess:dotfiles "vim" Enter
  
  tmux new-window -t $sess -n pebblefields
  tmux send-keys -t $sess:pebblefields "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:pebblefields "cd ~/projects/pebblefields.com" Enter
  tmux send-keys -t $sess:pebblefields "vim" Enter

  #tmux new-window -t $sess -n mutt "mutt"

  #select first
  tmux select-window -t $sess:lib

  #chmod 777 /tmp/pair

  tmux -2 attach-session -t $sess
  #tmux -S /tmp/pair -2 attach-session -t $sess

}

