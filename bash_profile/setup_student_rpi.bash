

setup_student_rpi() {

  sess=forward

  #----- lessons
  tmux new-session -s $sess -d -n lessons
  tmux send-keys -t $sess:lessons "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:lessons "cd ~/lessons" Enter
  #tmux send-keys -t $sess:lessons "vim" Enter

  tmux split-window -v -l 12 -t $sess:lessons
  tmux send-keys -t $sess:lessons.2 "cd ~/lessons" Enter

  #----- server
  tmux new-window -t $sess -n server
  tmux send-keys -t $sess:server "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t $sess:server "cd ~/server" Enter

  tmux split-window -v -l 12 -t $sess:server
  tmux send-keys -t $sess:server.2 "cd ~/server" Enter
  tmux select-pane -t $sess:server.1


  #select first
  tmux select-window -t $sess:lessons

  tmux -2 attach-session -t $sess

}

