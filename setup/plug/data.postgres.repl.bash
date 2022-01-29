#!/bin/bash

alias plug.data.postgres.repl="plug_postgres_repl"

plug_postgres_repl() {
  tmux new-window -t "$1" -n postgres
  tmux send-keys -t "$1":postgres "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":postgres "cd ~/projects/playground-data/postgres/repl" Enter
  tmux send-keys -t "$1":postgres "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":postgres
  tmux send-keys -t "$1":postgres.2 "mkdir postgres" Enter
  tmux send-keys -t "$1":postgres.2 "cd postgres" Enter

  tmux select-pane -t "$1":postgres.1
}
