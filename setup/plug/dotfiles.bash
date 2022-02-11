#!/bin/bash

alias plug.dotfiles.exercises="dotfiles_exercises"

dotfiles_exercises() {
  tmux new-window -t "$1" -n dotfiles-exercises
  tmux send-keys -t "$1":dotfiles-exercises "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":dotfiles-exercises "cd ~/projects/dotfiles/exercises" Enter
  tmux send-keys -t "$1":dotfiles-exercises "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":dotfiles-exercises
  tmux send-keys -t "$1":dotfiles-exercises.2 "cd ~/projects/dotfiles/exercises" Enter

  tmux select-pane -t "$1":dotfiles-exercises.1
}

alias plug.dotfiles.ref="dotfiles_ref"

dotfiles_ref() {
  tmux new-window -t "$1" -n dotfiles-ref
  tmux send-keys -t "$1":dotfiles-ref "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":dotfiles-ref "cd ~/projects/dotfiles/ref" Enter
  tmux send-keys -t "$1":dotfiles-ref "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":dotfiles-ref
  tmux send-keys -t "$1":dotfiles-ref.2 "cd ~/projects/dotfiles/ref" Enter

  tmux select-pane -t "$1":dotfiles-ref.1
}

alias plug.dotfiles.remira-impl="dotfiles_remira-impl"

dotfiles_remira-impl() {
  tmux new-window -t "$1" -n dotfiles-remira-impl
  tmux send-keys -t "$1":dotfiles-remira-impl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":dotfiles-remira-impl "cd ~/projects/dotfiles/remira-impl" Enter
  tmux send-keys -t "$1":dotfiles-remira-impl "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":dotfiles-remira-impl
  tmux send-keys -t "$1":dotfiles-remira-impl.2 "cd ~/projects/dotfiles/remira-impl" Enter

  tmux select-pane -t "$1":dotfiles-remira-impl.1
}

alias plug.dotfiles.repl="dotfiles_repl"

dotfiles_repl() {
  tmux new-window -t "$1" -n dotfiles-repl
  tmux send-keys -t "$1":dotfiles-repl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":dotfiles-repl "cd ~/projects/dotfiles/repl" Enter
  tmux send-keys -t "$1":dotfiles-repl "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":dotfiles-repl
  tmux send-keys -t "$1":dotfiles-repl.2 "cd ~/projects/dotfiles/repl" Enter

  tmux select-pane -t "$1":dotfiles-repl.1
}

# just use repl...
alias plug.dotfiles.curl="plug_dotfiles_curl"

plug_dotfiles_curl() {
  tmux new-window -t "$1" -n curl
  tmux send-keys -t "$1":curl "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":curl "vim ~/projects/dotfiles/repl/curl.md" Enter
  
  # curl from where you are in case you want to save a file
  tmux split-window -v -l 24 -t "$1":curl

  tmux select-pane -t "$1":curl.1
}

alias plug.dotfiles.git="plug_dotfiles_git"

plug_dotfiles_git() {
  tmux new-window -t "$1" -n git
  tmux send-keys -t "$1":git "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":git "cd ~/projects/dotfiles/repl/git" Enter
  tmux send-keys -t "$1":git "vim README.md" Enter
  
  tmux split-window -v -l 24 -t "$1":git
  tmux send-keys -t "$1":git.2 "cd ~/projects/dotfiles/repl/git/origin" Enter

  tmux split-window -v -l 24 -t "$1":git
  tmux send-keys -t "$1":git.3 "cd ~/projects/dotfiles/repl/git/client1" Enter

  tmux split-window -h -l 50 -t "$1":git
  tmux send-keys -t "$1":git.4 "cd ~/projects/dotfiles/repl/git/client2" Enter

  tmux select-pane -t "$1":git.1
}
