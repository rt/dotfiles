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

  #----- skeleton-spec
  tmux new-window -t $sess -n skeleton-spec
  tmux send-keys -t $sess:skeleton-spec "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:skeleton-spec "cd ~/projects/skeleton/skeleton-spec" Enter
  tmux send-keys -t $sess:skeleton-spec "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:skeleton-spec
  tmux send-keys -t $sess:skeleton-spec.2 "cd ~/projects/skeleton/skeleton-spec" Enter

  tmux select-pane -t $sess:skeleton-spec.1

  #-----

  #select first
  tmux select-window -t $sess:js

  tmux -2 attach-session -t $sess

}

