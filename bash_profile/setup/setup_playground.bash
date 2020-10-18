#!/bin/bash

setup.playground="setup_playground"
setup.create.playground="structurePlayground";

function structurePlayground() {
  mkdir playground;
  cd playground;
  # for ...
}

setup_playground() {

  sess=playground

  #----- java
  tmux new-session -s $sess -d -n java
  tmux send-keys -t $sess:java "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:java "cd ~/projects/playground/playground-java" Enter
  tmux send-keys -t $sess:java "vim" Enter

  tmux split-window -v -l 24 -t $sess:java
  tmux send-keys -t $sess:java.2 "cd ~/projects/playground/playground-java" Enter

  #----- postgres
  tmux new-window -t $sess -n postgres
  tmux send-keys -t $sess:postgres "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:postgres "cd ~/projects/playground/playground-postgres" Enter
  tmux send-keys -t $sess:postgres "vim" Enter
  
  #tmux split-window -h -l 85 -t $sess:postgres
  tmux split-window -v -l 24 -t $sess:postgres
  tmux send-keys -t $sess:postgres.2 "cd ~/projects/playground/playground-postgres" Enter

  tmux split-window -v -l 24 -t $sess:postgres
  tmux send-keys -t $sess:postgres.3 "cd ~/projects/playground/playground-postgres" Enter

  tmux select-pane -t $sess:postgres.1

  #----- javascript
  tmux new-window -t $sess -n javascript
  tmux send-keys -t $sess:javascript "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:javascript "cd ~/projects/playground/playground-javascript" Enter
  tmux send-keys -t $sess:javascript "vim" Enter

  tmux split-window -v -l 24 -t $sess:javascript
  tmux send-keys -t $sess:javascript.2 "cd ~/projects/playground/playground-javascript" Enter
  tmux select-pane -t $sess:javascript.1

  #----- go
  tmux new-window -t $sess -n go
  tmux send-keys -t $sess:go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:go "cd ~/projects/playground/playground-go" Enter
  tmux send-keys -t $sess:go "vim" Enter

  tmux split-window -v -l 24 -t $sess:go
  tmux send-keys -t $sess:go.2 "cd ~/projects/playground/playground-go" Enter
  tmux select-pane -t $sess:go.1

  #----- python
  tmux new-window -t $sess -n python
  tmux send-keys -t $sess:python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:python "cd ~/projects/playground/playground-python" Enter
  tmux send-keys -t $sess:python "vim" Enter

  tmux split-window -v -l 24 -t $sess:python
  tmux send-keys -t $sess:python.2 "cd ~/projects/playground/playground-python" Enter
  tmux select-pane -t $sess:python.1
  

  #select first
  tmux select-window -t $sess:java

  tmux -2 attach-session -t $sess

}

