#!/bin/bash

alias setup.project="setup_project"

# Usage: 
#   mkdir myproject
#   cd myproject
#   setup.project
#   ... plug ...
setup_project() {

  # session name takes name of directory
  sess=${PWD##*/}

  # top tab give over all view
  tmux new-session -s $sess -d -n top

  tmux -2 attach-session -t $sess
}
