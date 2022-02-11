#!/bin/bash

alias plug.bash.curl="plug_bash_curl"

plug_bash_curl() {
  tmux new-window -t "$1" -n curl
  tmux send-keys -t "$1":curl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":curl "vim ~/projects/dotfiles/repl/curl.md" Enter
  
  # curl from where you are in case you want to save a file
  tmux split-window -v -l 24 -t "$1":curl

  tmux select-pane -t "$1":curl.1
}

