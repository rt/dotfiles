#!/bin/bash

alias plug.playground.javascript="playground_javascript"

playground_javascript() {
  tmux new-window -t "$1" -n javascript
  tmux send-keys -t "$1":javascript "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":javascript "cd ~/projects/playground-javascript" Enter
  tmux send-keys -t "$1":javascript "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":javascript
  tmux send-keys -t $1:javascript.2 "cd ~/projects/playground-javascript" Enter

  tmux select-pane -t "$1":javascript.1
}

alias plug.playground.java="playground_java"

playground_java() {
  tmux new-window -t "$1" -n java
  tmux send-keys -t "$1":java "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":java "cd ~/projects/playground-java" Enter
  tmux send-keys -t "$1":java "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":java
  tmux send-keys -t "$1":java.2 "cd ~/projects/playground-java" Enter

  tmux select-pane -t "$1":java.1
}

alias plug.playground.clojure="playground_clojure"

playground_clojure() {
  tmux new-window -t "$1" -n clojure
  tmux send-keys -t "$1":clojure "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":clojure "cd ~/projects/playground-clojure" Enter
  tmux send-keys -t "$1":clojure "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":clojure
  tmux send-keys -t "$1":clojure.2 "cd ~/projects/playground-clojure" Enter

  tmux select-pane -t "$1":clojure.1
}

alias plug.playground.cloud="playground_cloud"

playground_cloud() {
  tmux new-window -t "$1" -n cloud
  tmux send-keys -t "$1":cloud "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":cloud "cd ~/projects/playground-cloud" Enter
  tmux send-keys -t "$1":cloud "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":cloud
  tmux send-keys -t "$1":cloud.2 "cd ~/projects/playground-cloud" Enter

  tmux select-pane -t "$1":cloud.1
}

alias plug.playground.data="playground_data"

playground_data() {
  tmux new-window -t "$1" -n data
  tmux send-keys -t "$1":data "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":data "cd ~/projects/playground-data" Enter
  tmux send-keys -t "$1":data "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":data
  tmux send-keys -t "$1":data.2 "cd ~/projects/playground-data" Enter

  tmux select-pane -t "$1":data.1
}

alias plug.playground.misc="playground_misc"

playground_misc() {
  tmux new-window -t "$1" -n misc
  tmux send-keys -t "$1":misc "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":misc "cd ~/projects/playground-misc" Enter
  tmux send-keys -t "$1":misc "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":misc
  tmux send-keys -t "$1":misc.2 "cd ~/projects/playground-misc" Enter

  tmux select-pane -t "$1":misc.1
}
