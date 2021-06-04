#!/bin/bash

alias setup.playground="setup_playground"

setup_playground() {

  sess=playground

  #----- js
  tmux new-session -s $sess -d -n js
  tmux send-keys -t $sess:js "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:js "cd ~/projects/dotfiles/quick-reference/javascript" Enter
  tmux send-keys -t $sess:js "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:js
  tmux send-keys -t $sess:js.2 "cd ~/projects/dotfiles/playground/javascript" Enter

  tmux select-pane -t $sess:js.1

  #----- java
  tmux new-window -t $sess -n java
  tmux send-keys -t $sess:java "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:java "cd ~/projects/dotfiles/quick-reference/java" Enter
  tmux send-keys -t $sess:java "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:java
  tmux send-keys -t $sess:java.2 "cd ~/projects/dotfiles/playground/java" Enter

  tmux select-pane -t $sess:java.1

  #----- postgres
  tmux new-window -t $sess -n postgres
  tmux send-keys -t $sess:postgres "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:postgres "cd ~/projects/dotfiles/quick-reference/postgres" Enter
  tmux send-keys -t $sess:postgres "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:postgres
  tmux send-keys -t $sess:postgres.2 "cd ~/projects/dotfiles/playground/postgres" Enter

  tmux select-pane -t $sess:postgres.1

  #----- bash
  tmux new-window -t $sess -n bash
  tmux send-keys -t $sess:bash "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:bash "cd ~/projects/dotfiles/quick-reference/bash" Enter
  tmux send-keys -t $sess:bash "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:bash
  tmux send-keys -t $sess:bash.2 "cd ~/projects/dotfiles/playground/bash" Enter

  tmux select-pane -t $sess:bash.1

  #----- python
  tmux new-window -t $sess -n python
  tmux send-keys -t $sess:python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:python "cd ~/projects/dotfiles/quick-reference/python" Enter
  tmux send-keys -t $sess:python "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:python
  tmux send-keys -t $sess:python.2 "cd ~/projects/dotfiles/playground/python" Enter

  tmux select-pane -t $sess:python.1

  #----- go
  tmux new-window -t $sess -n go
  tmux send-keys -t $sess:go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:go "cd ~/projects/dotfiles/quick-reference/go" Enter
  tmux send-keys -t $sess:go "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:go
  tmux send-keys -t $sess:go.2 "cd ~/projects/dotfiles/playground/go" Enter

  tmux select-pane -t $sess:go.1

  #----- groovy
  tmux new-window -t $sess -n groovy
  tmux send-keys -t $sess:groovy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:groovy "cd ~/projects/dotfiles/quick-reference/groovy" Enter
  tmux send-keys -t $sess:groovy "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:groovy
  tmux send-keys -t $sess:groovy.2 "cd ~/projects/dotfiles/playground/groovy" Enter

  tmux select-pane -t $sess:groovy.1

  #----- clojure
  tmux new-window -t $sess -n clojure
  tmux send-keys -t $sess:clojure "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clojure "cd ~/projects/dotfiles/quick-reference/clojure" Enter
  tmux send-keys -t $sess:clojure "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:clojure
  tmux send-keys -t $sess:clojure.2 "cd ~/projects/dotfiles/playground/clojure" Enter

  tmux select-pane -t $sess:clojure.1

  #----- git
  tmux new-window -t $sess -n git
  tmux send-keys -t $sess:git "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:git "cd ~/projects/dotfiles/quick-reference/git" Enter
  tmux send-keys -t $sess:clojure "vim repl.md" Enter

  tmux split-window -v -l 24 -t $sess:git
  tmux send-keys -t $sess:git.2 "cd ~/projects/dotfiles/playground/git/origin" Enter

  tmux split-window -v -l 24 -t $sess:git
  tmux send-keys -t $sess:git.3 "cd ~/projects/dotfiles/playground/git/client1" Enter

  tmux split-window -h -l 50 -t $sess:git
  tmux send-keys -t $sess:git.4 "cd ~/projects/dotfiles/playground/git/client2" Enter

  tmux select-pane -t $sess:git.1

  #-----

  #select first
  tmux select-window -t $sess:dotfiles

  tmux -2 attach-session -t $sess

}

