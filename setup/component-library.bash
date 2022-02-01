#!/bin/bash

alias setup.project="setup_project_component-library"

setup_project_component-library() {

  # session name takes name of directory (go into directory first)
  sess=${PWD##*/}

  # temp
  tmux new-session -s $sess -d -n tempwindow

  plug.project.component-library
  plug.project.skeleton

  # kill temporary first window (didn't figure out a way to creat without it?)
  tmux kill-window -t tempwindow

  #select first
  tmux select-window -t:1

  tmux -2 attach-session -t $sess

}
