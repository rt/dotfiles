#!/bin/bash

alias setup.work.automation="setup_work_automation"

setup_work_automation() {

  sess=workauto

  # automation
  tmux new-session -s $sess -d -n automation
  tmux send-keys -t $sess:automation "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:automation "vim src/test/resources/rtsunoda.properties" Enter

  tmux split-window -v -l 14 -t $sess:automation
  tmux send-keys -t $sess:automation.2 "mvn -P automation -Dit.test=SomeTestIT verify"

  tmux split-window -v -l 14 -t $sess:automation
  tmux send-keys -t $sess:automation.3 "mvn verify -P automation -Dtest.groups=some-group"

  tmux split-window -v -l 14 -t $sess:automation
  tmux send-keys -t $sess:automation.4 "cd ../migrations/release_independent_tools/automation" Enter

  tmux select-pane -t $sess:automation.1

  #select first
  tmux select-window -t $sess:automation

  tmux -2 attach-session -t $sess

}
