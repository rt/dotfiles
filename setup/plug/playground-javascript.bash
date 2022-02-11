#!/bin/bash

alias plug.javascript.exercises="javascript_exercises"

javascript_exercises() {
  tmux new-window -t "$1" -n javascript-exercises
  tmux send-keys -t "$1":javascript-exercises "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":javascript-exercises "cd ~/projects/playground-javascript/exercises" Enter
  tmux send-keys -t "$1":javascript-exercises "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":javascript-exercises
  tmux send-keys -t "$1":javascript-exercises.2 "cd ~/projects/playground-javascript/exercises" Enter
  tmux send-keys -t "$1":javascript-exercises.2 "npm test -- my-exercise"

  tmux select-pane -t "$1":javascript-exercises.1
}

alias plug.javascript.ref="javascript_ref"

javascript_ref() {
  tmux new-window -t "$1" -n javascript-ref
  tmux send-keys -t "$1":javascript-ref "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":javascript-ref "cd ~/projects/playground-javascript/ref" Enter
  tmux send-keys -t "$1":javascript-ref "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":javascript-ref
  tmux send-keys -t "$1":javascript-ref.2 "cd ~/projects/playground-javascript/ref" Enter

  tmux select-pane -t "$1":javascript-ref.1
}

alias plug.javascript.remira-impl="javascript_remira-impl"

javascript_remira-impl() {
  tmux new-window -t "$1" -n javascript-remira-impl
  tmux send-keys -t "$1":javascript-remira-impl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":javascript-remira-impl "cd ~/projects/playground-javascript/remira-impl" Enter
  tmux send-keys -t "$1":javascript-remira-impl "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":javascript-remira-impl
  tmux send-keys -t "$1":javascript-remira-impl.2 "cd ~/projects/playground-javascript/remira-impl" Enter

  tmux select-pane -t "$1":javascript-remira-impl.1
}

alias plug.javascript.repl="javascript_repl"

javascript_repl() {
  tmux new-window -t "$1" -n javascript-repl
  tmux send-keys -t "$1":javascript-repl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":javascript-repl "cd ~/projects/playground-javascript/repl" Enter
  tmux send-keys -t "$1":javascript-repl "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":javascript-repl
  tmux send-keys -t "$1":javascript-repl.2 "cd ~/projects/playground-javascript/repl" Enter

  tmux select-pane -t "$1":javascript-repl.1
}

