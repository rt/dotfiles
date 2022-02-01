#!/bin/bash

alias setup.work="setup_work"

setup_work() {

  # sess=${PWD##*/}
  sess=workdev

  # dev
  tmux new-session -s $sess -d -n dev
  tmux send-keys -t $sess:dev "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dev "cd ~/dev/repos/dev" Enter
  # tmux send-keys -t $sess:dev "ctags -R --language-force=java -f .tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/" Enter
  tmux send-keys -t $sess:dev "vim" Enter
  
  tmux select-pane -t $sess:dev.1

  plug.work.shopping
  plug.work.platform
  plug.work.work

  #select first
  tmux select-window -t:1

  tmux -2 attach-session -t $sess

}
