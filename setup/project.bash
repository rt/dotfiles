#!/bin/bash

alias setup.project="setup_project"

setup_project() {

  # session name takes name of directory (go into directory first)
  sess=${PWD##*/}

  # temp
  tmux new-session -s $sess -d -n tempwindow

  # plug.project.server.javascript $sess

  # you actually don't need to pass the $sess because the current session is default
  plug.project.remira


  # kill temporary first window (didn't figure out a way to creat without it?)
  tmux kill-window -t tempwindow

  #select first
  tmux select-window -t:1

  tmux -2 attach-session -t $sess

}
