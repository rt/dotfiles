#!/bin/bash

alias plug.java.exercises="java_exercises"

java_exercises() {
  tmux new-window -t "$1" -n java-exercises
  tmux send-keys -t "$1":java-exercises "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":java-exercises "cd ~/projects/playground-java/exercises" Enter
  tmux send-keys -t "$1":java-exercises "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":java-exercises
  tmux send-keys -t "$1":java-exercises.2 "cd ~/projects/playground-java/exercises" Enter

  tmux select-pane -t "$1":java-exercises.1
}

alias plug.java.ref="java_ref"

java_ref() {
  tmux new-window -t "$1" -n java-ref
  tmux send-keys -t "$1":java-ref "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":java-ref "cd ~/projects/playground-java/ref" Enter
  tmux send-keys -t "$1":java-ref "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":java-ref
  tmux send-keys -t "$1":java-ref.2 "cd ~/projects/playground-java/ref" Enter

  tmux select-pane -t "$1":java-ref.1
}

alias plug.java.remira-impl="java_remira-impl"

java_remira-impl() {
  tmux new-window -t "$1" -n java-remira-impl
  tmux send-keys -t "$1":java-remira-impl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":java-remira-impl "cd ~/projects/playground-java/remira-impl" Enter
  tmux send-keys -t "$1":java-remira-impl "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":java-remira-impl
  tmux send-keys -t "$1":java-remira-impl.2 "cd ~/projects/playground-java/remira-impl" Enter

  tmux select-pane -t "$1":java-remira-impl.1
}

alias plug.java.repl="java_repl"

java_repl() {
  tmux new-window -t "$1" -n java-repl
  tmux send-keys -t "$1":java-repl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":java-repl "cd ~/projects/playground-java/repl" Enter
  tmux send-keys -t "$1":java-repl "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":java-repl
  tmux send-keys -t "$1":java-repl.2 "cd ~/projects/playground-java/repl" Enter

  tmux select-pane -t "$1":java-repl.1
}

