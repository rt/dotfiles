#!/bin/bash

alias setup.playground.misc="setup_playground_misc"

setup_playground_misc() {

  sess=playgroundmisc

  #----- top
  tmux new-session -s $sess -d -n top
  tmux send-keys -t $sess:top "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:top "cd ~/projects/playground-misc" Enter
  tmux send-keys -t $sess:top "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:top
  tmux send-keys -t $sess:top.2 "cd ~/projects/playground-misc" Enter

  tmux select-pane -t $sess:top.1

  #----- python
  tmux new-window -t $sess -n python
  tmux send-keys -t $sess:python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:python "cd ~/projects/playground-misc/python" Enter
  tmux send-keys -t $sess:python "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:python
  tmux send-keys -t $sess:python.2 "cd ~/projects/playground-misc/python" Enter

  tmux select-pane -t $sess:python.1

  #----- go
  tmux new-window -t $sess -n go
  tmux send-keys -t $sess:go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:go "cd ~/projects/playground-misc/go" Enter
  tmux send-keys -t $sess:go "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:go
  tmux send-keys -t $sess:go.2 "cd ~/projects/playground-misc/go" Enter

  tmux select-pane -t $sess:go.1

  #----- groovy
  tmux new-window -t $sess -n groovy
  tmux send-keys -t $sess:groovy "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:groovy "cd ~/projects/playground-misc/groovy" Enter
  tmux send-keys -t $sess:groovy "vim repl.md" Enter
  
  tmux split-window -v -l 24 -t $sess:groovy
  tmux send-keys -t $sess:groovy.2 "cd ~/projects/playground-misc/groovy" Enter

  tmux select-pane -t $sess:groovy.1

  #----- git
  tmux new-window -t $sess -n git
  tmux send-keys -t $sess:git "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:git "cd ~/projects/playground-misc/git" Enter
  tmux send-keys -t $sess:clojure "vim repl.md" Enter

  tmux split-window -v -l 24 -t $sess:git
  tmux send-keys -t $sess:git.2 "cd ~/projects/playground-misc/git/origin" Enter

  tmux split-window -v -l 24 -t $sess:git
  tmux send-keys -t $sess:git.3 "cd ~/projects/playground-misc/git/client1" Enter

  tmux split-window -h -l 50 -t $sess:git
  tmux send-keys -t $sess:git.4 "cd ~/projects/playground-misc/git/client2" Enter

  tmux select-pane -t $sess:git.1

  #-----

  #select first
  tmux select-window -t $sess:postgres

  tmux -2 attach-session -t $sess

}

