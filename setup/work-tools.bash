#!/bin/bash

alias setup.work.tools="setup_work_tools"

setup_work_tools() {

  sess=worktools

  ### work
  tmux new-session -s $sess -d -n work
  tmux send-keys -t $sess:work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:work "cd ~/projects/work" Enter
  tmux send-keys -t $sess:work "vim" Enter
  
  tmux split-window -v -l 14 -t $sess:work
  tmux send-keys -t $sess:work.2 "cd ~/projects/work" Enter

  tmux select-pane -t $sess:work.1
  
  # analyze
  tmux new-window -t $sess -n analyze
  tmux send-keys -t $sess:analyze "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:analyze "cd ~/projects/work/analyze" Enter
  tmux send-keys -t $sess:analyze "vim" Enter

  tmux split-window -v -l 14 -t $sess:analyze
  tmux send-keys -t $sess:analyze.2 "cd ~/projects/work/analyze" Enter

  tmux select-pane -t $sess:analyze.1

  # repl
  tmux new-window -t $sess -n repl
  tmux send-keys -t $sess:repl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:repl "cd ~/projects/work/notes" Enter
  tmux send-keys -t $sess:repl "vim" Enter

  tmux split-window -v -l 14 -t $sess:repl
  tmux send-keys -t $sess:repl.2 "cd ~/projects/work/notes" Enter
  tmux send-keys -t $sess:repl.2 "psql -U postgres -h localhost"

  tmux select-pane -t $sess:repl.1
  
  # merchandise
  tmux new-window -t $sess -n merchandise
  tmux send-keys -t $sess:merchandise "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:merchandise "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/merchandise" Enter
  tmux send-keys -t $sess:merchandise "vim" Enter

  tmux split-window -v -l 14 -t $sess:merchandise
  tmux send-keys -t $sess:merchandise.2 "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/merchandise" Enter

  tmux select-pane -t $sess:merchandise.1

  # super-rentals
  tmux new-window -t $sess -n super-rentals
  tmux send-keys -t $sess:super-rentals "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:super-rentals "cd ~/dev/repos/super-rentals" Enter
  tmux send-keys -t $sess:super-rentals "vim" Enter

  tmux split-window -v -l 14 -t $sess:super-rentals
  tmux send-keys -t $sess:super-rentals.2 "cd ~/dev/repos/super-rentals" Enter

  tmux select-pane -t $sess:super-rentals.1

  # ember-quickstart
  tmux new-window -t $sess -n ember-quickstart
  tmux send-keys -t $sess:ember-quickstart "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:ember-quickstart "cd ~/dev/repos/ember-quickstart" Enter
  tmux send-keys -t $sess:ember-quickstart "vim" Enter

  tmux split-window -v -l 14 -t $sess:ember-quickstart
  tmux send-keys -t $sess:ember-quickstart.2 "cd ~/dev/repos/ember-quickstart" Enter

  tmux select-pane -t $sess:ember-quickstart.1


  #select first
  tmux select-window -t $sess:work

  tmux -2 attach-session -t $sess

}
