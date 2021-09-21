#!/bin/bash

alias setup.playground="setup_playground"

setup_playground() {

  sess=playground

  #----- js
  tmux new-session -s $sess -d -n js
  tmux send-keys -t $sess:js "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:js "cd ~/projects/playground-javascript" Enter
  tmux send-keys -t $sess:js "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:js
  tmux send-keys -t $sess:js.2 "cd ~/projects/playground-javascript" Enter

  tmux select-pane -t $sess:js.1

  #----- clojure
  tmux new-window -t $sess -n clojure
  tmux send-keys -t $sess:clojure "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clojure "cd ~/projects/playground-clojure" Enter
  tmux send-keys -t $sess:clojure "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:clojure
  tmux send-keys -t $sess:clojure.2 "cd ~/projects/playground-clojure" Enter

  tmux select-pane -t $sess:clojure.1

  #----- java
  tmux new-window -t $sess -n java
  tmux send-keys -t $sess:java "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:java "cd ~/projects/playground-java" Enter
  tmux send-keys -t $sess:java "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:java
  tmux send-keys -t $sess:java.2 "cd ~/projects/playground-java" Enter

  tmux select-pane -t $sess:java.1

  #----- bash
  tmux new-window -t $sess -n bash
  tmux send-keys -t $sess:bash "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:bash "cd ~/projects/playground-bash" Enter
  tmux send-keys -t $sess:bash "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:bash
  tmux send-keys -t $sess:bash.2 "cd ~/projects/playground-bash" Enter

  tmux select-pane -t $sess:bash.1

  #----- data
  tmux new-window -t $sess -n data
  tmux send-keys -t $sess:data "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:data "cd ~/projects/playground-data" Enter
  tmux send-keys -t $sess:data "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:data
  tmux send-keys -t $sess:data.2 "cd ~/projects/playground-data" Enter

  tmux select-pane -t $sess:data.1

  #----- cloud
  tmux new-window -t $sess -n cloud
  tmux send-keys -t $sess:cloud "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:cloud "cd ~/projects/playground-cloud" Enter
  tmux send-keys -t $sess:cloud "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:cloud
  tmux send-keys -t $sess:cloud.2 "cd ~/projects/playground-cloud" Enter

  tmux select-pane -t $sess:cloud.1

  #----- misc
  tmux new-window -t $sess -n misc
  tmux send-keys -t $sess:misc "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:misc "cd ~/projects/playground-misc" Enter
  tmux send-keys -t $sess:misc "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:misc
  tmux send-keys -t $sess:misc.2 "cd ~/projects/playground-misc" Enter

  tmux select-pane -t $sess:misc.1

  #----- remira
  tmux new-window -t $sess -n remira
  tmux send-keys -t $sess:remira "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:remira "cd ~/projects/remira" Enter
  tmux send-keys -t $sess:remira "vim" Enter

  tmux split-window -v -l 24 -t $sess:remira
  tmux send-keys -t $sess:remira.2 "cd ~/projects/remira" Enter

  tmux select-pane -t $sess:remira.1

  #-----

  #select first
  tmux select-window -t $sess:js

  tmux -2 attach-session -t $sess

}

