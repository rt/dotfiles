#!/bin/bash

alias setup.work.automation="setup_work_automation"

setup_work_automation() {

  sess=workauto

  # automation
  tmux new-session -s $sess -d -n automation
  tmux send-keys -t $sess:automation "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:automation "vim src/test/resources/rtsunoda.properties" Enter

  tmux select-pane -t $sess:automation.1

  # single-test
  tmux new-window -t $sess -n single-test
  tmux send-keys -t $sess:single-test "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:single-test "mvn -P automation -Dit.test=SomeTestIT verify"

  tmux select-pane -t $sess:single-test.1

  # group-test
  tmux new-window -t $sess -n group-test
  tmux send-keys -t $sess:group-test "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:group-test "mvn verify -P automation -Dtest.groups=some-group"

  tmux select-pane -t $sess:group-test.1

  # release_independent_tools
  tmux new-window -t $sess -n release_independent_tools
  tmux send-keys -t $sess:release_independent_tools "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:release_independent_tools "cd ../migrations/release_independent_tools/automation" Enter

  tmux select-pane -t $sess:release_independent_tools.1

  #select first
  tmux select-window -t $sess:automation

  tmux -2 attach-session -t $sess

}
