#!/bin/bash

alias setup.raspbian="setup_student_rpi"

setup_student_rpi() {

  sess=student

  #----- lessons
  tmux -S /tmp/pair new-session -s $sess -d -n lessons
  tmux -S /tmp/pair send-keys -t $sess:lessons "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:lessons "cd ~/lessons" Enter
  # tmux -S /tmp/pair send-keys -t $sess:lessons "vim" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:lessons
  tmux -S /tmp/pair send-keys -t $sess:lessons.2 "cd ~/lessons" Enter

  #----- server
  tmux -S /tmp/pair new-window -t $sess -n server
  tmux -S /tmp/pair send-keys -t $sess:server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux -S /tmp/pair send-keys -t $sess:server "cd ~/server" Enter

  tmux -S /tmp/pair split-window -v -l 12 -t $sess:server
  tmux -S /tmp/pair send-keys -t $sess:server.2 "cd ~/server" Enter
  tmux -S /tmp/pair select-pane -t $sess:server.1


  #select first
  tmux -S /tmp/pair select-window -t $sess:lessons

  tmux -S /tmp/pair -2 attach-session -t $sess

}

