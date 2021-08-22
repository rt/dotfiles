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

  #----- postgres
  tmux new-window -t $sess -n postgres
  tmux send-keys -t $sess:postgres "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:postgres "cd ~/projects/playground-misc/src/postgres" Enter
  tmux send-keys -t $sess:postgres "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:postgres
  tmux send-keys -t $sess:postgres.2 "cd ~/projects/playground-misc/src/postgres" Enter

  tmux select-pane -t $sess:postgres.1

  #----- bash
  tmux new-window -t $sess -n bash
  tmux send-keys -t $sess:bash "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:bash "cd ~/projects/playground-bash" Enter
  tmux send-keys -t $sess:bash "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:bash
  tmux send-keys -t $sess:bash.2 "cd ~/projects/playground-bash" Enter

  tmux select-pane -t $sess:bash.1

  #----- python
  tmux new-window -t $sess -n python
  tmux send-keys -t $sess:python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:python "cd ~/projects/playground-misc/src/python" Enter
  tmux send-keys -t $sess:python "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:python
  tmux send-keys -t $sess:python.2 "cd ~/projects/playground-misc/src/python" Enter

  tmux select-pane -t $sess:python.1

  #----- go
  tmux new-window -t $sess -n go
  tmux send-keys -t $sess:go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:go "cd ~/projects/playground-misc/src/go" Enter
  tmux send-keys -t $sess:go "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:go
  tmux send-keys -t $sess:go.2 "cd ~/projects/playground-misc/src/go" Enter

  tmux select-pane -t $sess:go.1

  #----- groovy
  tmux new-window -t $sess -n groovy
  tmux send-keys -t $sess:groovy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:groovy "cd ~/projects/playground-misc/src/groovy" Enter
  tmux send-keys -t $sess:groovy "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:groovy
  tmux send-keys -t $sess:groovy.2 "cd ~/projects/playground-misc/src/groovy" Enter

  tmux select-pane -t $sess:groovy.1

  #----- git
  tmux new-window -t $sess -n git
  tmux send-keys -t $sess:git "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:git "cd ~/projects/playground-misc/src/git" Enter
  tmux send-keys -t $sess:clojure "vim repl.md" Enter

  tmux split-window -v -l 24 -t $sess:git
  tmux send-keys -t $sess:git.2 "cd ~/projects/playground-misc/src/git/origin" Enter

  tmux split-window -v -l 24 -t $sess:git
  tmux send-keys -t $sess:git.3 "cd ~/projects/playground-misc/src/git/client1" Enter

  tmux split-window -h -l 50 -t $sess:git
  tmux send-keys -t $sess:git.4 "cd ~/projects/playground-misc/src/git/client2" Enter

  tmux select-pane -t $sess:git.1

  #-----

  #select first
  tmux select-window -t $sess:js

  tmux -2 attach-session -t $sess

}

