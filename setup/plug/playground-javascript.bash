#!/bin/bash

alias plug.javascript.server-typescript="javascript_server-typescript"

javascript_server-typescript() {
  cd ~/projects/playground-javascript/remira-impl/services/servers/typescript-basic/_templates
  nvm use v17.6
  code .
  cd -
}

alias plug.javascript.exercises-js="javascript_exercises-js"

javascript_exercises-js() {
  cd ~/projects/playground-javascript/exercises/javascript
  nvm use v17.6
  code .
  cd -
  # tmux new-window -t "$1" -n javascript-exercises-js
  # tmux send-keys -t "$1":javascript-exercises-js "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  # tmux send-keys -t "$1":javascript-exercises-js "cd ~/projects/playground-javascript/exercises/javascript" Enter
  # tmux send-keys -t "$1":javascript-exercises-js "vim README.md" Enter
  #
  # tmux split-window -v -l 24 -t "$1":javascript-exercises-js
  # tmux send-keys -t "$1":javascript-exercises-js.2 "cd ~/projects/playground-javascript/exercises/javascript" Enter
  # tmux send-keys -t "$1":javascript-exercises-js.2 "npm test -- my-exercise"
  #
  # tmux select-pane -t "$1":javascript-exercises-js.1
}

alias plug.javascript.exercises-ts="javascript_exercises-ts"

javascript_exercises-ts() {
  cd ~/projects/playground-javascript/exercises/typescript
  nvm use v17.6
  code .
  cd -
  # tmux new-window -t "$1" -n javascript-exercises-ts
  # tmux send-keys -t "$1":javascript-exercises-ts "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  # tmux send-keys -t "$1":javascript-exercises-ts "cd ~/projects/playground-javascript/exercises/typescript" Enter
  # tmux send-keys -t "$1":javascript-exercises-ts "vim README.md" Enter
  #
  # tmux split-window -v -l 24 -t "$1":javascript-exercises-ts
  # tmux send-keys -t "$1":javascript-exercises-ts.2 "cd ~/projects/playground-javascript/exercises/typescript" Enter
  # tmux send-keys -t "$1":javascript-exercises-ts.2 "npm test -- my-exercise"
  #
  # tmux select-pane -t "$1":javascript-exercises-ts.1
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

