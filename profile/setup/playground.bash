#!/bin/bash

alias setup.playground="setup_playground"

setup_playground() {

  sess=playground

  #----- dotfiles
  tmux new-session -s $sess -d -n dotfiles
  tmux send-keys -t $sess:dotfiles "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:dotfiles "cd ~/projects/dotfiles" Enter
  tmux send-keys -t $sess:dotfiles "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:dotfiles
  tmux send-keys -t $sess:dotfiles.2 "cd ~/projects/dotfiles/profile/" Enter
  tmux send-keys -t $sess:dotfiles "./bootstrap rtsunoda"

  tmux select-pane -t $sess:dotfiles.1

  #----- keyboard
  tmux new-window -t $sess -n keyboard
  tmux send-keys -t $sess:keyboard "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:keyboard "cd ~/projects/keyboard" Enter
  tmux send-keys -t $sess:keyboard "vim" Enter

  tmux split-window -v -l 24 -t $sess:keyboard
  tmux send-keys -t $sess:keyboard.3 "cd ~/projects/keyboard/" Enter
  tmux send-keys -t $sess:keyboard "./copy_qmk_files"

  tmux split-window -h -l 50 -t $sess:keyboard
  tmux send-keys -t $sess:keyboard.4 "cd ~/projects/qmk_firmware" Enter
  tmux send-keys -t $sess:keyboard "make handwired/mrkabuda:ryan:avrdude"

  #----- java
  tmux new-window -t $sess -n java
  tmux send-keys -t $sess:java "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:java "cd ~/projects/dotfiles/playground/java" Enter
  tmux send-keys -t $sess:java "vim" Enter

  tmux split-window -v -l 24 -t $sess:java
  tmux send-keys -t $sess:java.2 "cd ~/projects/dotfiles/playground/java" Enter

  #----- javascript
  tmux new-window -t $sess -n javascript
  tmux send-keys -t $sess:javascript "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:javascript "cd ~/projects/dotfiles/playground/javascript" Enter
  tmux send-keys -t $sess:javascript "vim" Enter
  
  tmux split-window -v -l 24 -t $sess:javascript
  tmux send-keys -t $sess:javascript.2 "cd ~/projects/dotfiles/playground/javascript" Enter

  tmux select-pane -t $sess:javascript.1

  #----- postgres
  tmux new-window -t $sess -n postgres
  tmux send-keys -t $sess:postgres "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:postgres "cd ~/projects/dotfiles/playground/postgres" Enter
  tmux send-keys -t $sess:postgres "vim" Enter

  tmux split-window -v -l 24 -t $sess:postgres
  tmux send-keys -t $sess:postgres.2 "cd ~/projects/dotfiles/playground/postgres" Enter
  tmux select-pane -t $sess:postgres.1

  #----- browser
  tmux new-window -t $sess -n browser
  tmux send-keys -t $sess:browser "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:browser "cd ~/projects/dotfiles/playground/browser" Enter
  tmux send-keys -t $sess:browser "vim" Enter

  tmux split-window -v -l 24 -t $sess:browser
  tmux send-keys -t $sess:browser.2 "cd ~/projects/dotfiles/playground/browser" Enter
  tmux select-pane -t $sess:browser.1

  #----- python
  tmux new-window -t $sess -n python
  tmux send-keys -t $sess:python "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:python "cd ~/projects/dotfiles/playground/python" Enter
  tmux send-keys -t $sess:python "vim" Enter

  tmux split-window -v -l 24 -t $sess:python
  tmux send-keys -t $sess:python.2 "cd ~/projects/dotfiles/playground/python" Enter
  tmux select-pane -t $sess:python.1

  #----- bash
  tmux new-window -t $sess -n bash
  tmux send-keys -t $sess:bash "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:bash "cd ~/projects/dotfiles/playground/bash" Enter
  tmux send-keys -t $sess:bash "vim" Enter

  tmux split-window -v -l 24 -t $sess:bash
  tmux send-keys -t $sess:bash.2 "cd ~/projects/dotfiles/playground/bash" Enter
  tmux select-pane -t $sess:bash.1

  #----- go
  tmux new-window -t $sess -n go
  tmux send-keys -t $sess:go "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:go "cd ~/projects/dotfiles/playground/go" Enter
  tmux send-keys -t $sess:go "vim" Enter

  tmux split-window -v -l 24 -t $sess:go
  tmux send-keys -t $sess:go.2 "cd ~/projects/dotfiles/playground/go" Enter
  tmux select-pane -t $sess:go.1

  #----- clojure
  tmux new-window -t $sess -n clojure
  tmux send-keys -t $sess:clojure "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clojure "cd ~/projects/dotfiles/playground/clojure" Enter
  tmux send-keys -t $sess:clojure "vim" Enter

  tmux split-window -v -l 24 -t $sess:clojure
  tmux send-keys -t $sess:clojure.2 "cd ~/projects/dotfiles/playground/clojure" Enter
  tmux select-pane -t $sess:clojure.1

  #----- clojurescript
  tmux new-window -t $sess -n clojurescript
  tmux send-keys -t $sess:clojurescript "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:clojurescript "cd ~/projects/dotfiles/playground/clojurescript" Enter
  tmux send-keys -t $sess:clojurescript "vim" Enter

  tmux split-window -v -l 24 -t $sess:clojurescript
  tmux send-keys -t $sess:clojurescript.2 "cd ~/projects/dotfiles/playground/clojurescript" Enter
  tmux select-pane -t $sess:clojurescript.1

  #select first
  tmux select-window -t $sess:dotfiles

  tmux -2 attach-session -t $sess

}

