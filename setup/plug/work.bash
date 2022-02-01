alias plug.work.merchandise="work_merchandise"

work_merchandise() {
  tmux new-window -t "$1" -n merchandise
  tmux send-keys -t "$1":merchandise "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":merchandise "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/merchandise" Enter
  # tmux send-keys -t "$1":merchandise "ctags_javascript scripts/" Enter
  tmux send-keys -t "$1":merchandise "npm run package.watch -- --dsn=qaone --dev=true"

  tmux split-window -v -l 14 -t "$1":merchandise
  tmux send-keys -t "$1":merchandise.2 "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/merchandise" Enter
  tmux send-keys -t "$1":merchandise.2 "npm run cover"

  tmux select-pane -t "$1":merchandise.1
}

alias plug.work.shopping="work_shopping"

work_shopping() {
  tmux new-window -t "$1" -n shopping
  tmux send-keys -t "$1":shopping "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":shopping "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping" Enter
  tmux send-keys -t "$1":shopping "ctags_javascript scripts/" Enter
  tmux send-keys -t "$1":shopping "npm run package.watch -- --dsn=qaone --dev=true"

  tmux split-window -v -l 14 -t "$1":shopping
  tmux send-keys -t "$1":shopping.2 "cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping" Enter
  tmux send-keys -t "$1":shopping.2 "npm test -- --bundle=liquid"

  tmux select-pane -t "$1":shopping.1
}

alias plug.work.platform="work_platform"

work_platform() {
  tmux new-window -t "$1" -n platform
  tmux send-keys -t "$1":platform "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":platform "cd ~/dev/repos/dev/platform/devenv" Enter
  tmux send-keys -t "$1":platform "docker compose up"
  
  tmux split-window -v -l 10 -t "$1":platform
  tmux send-keys -t "$1":platform.2 "cd ~/dev/repos/dev/platform/devenv" Enter
  tmux send-keys -t "$1":platform.2 "docker exec -it devenv_postgres_1 bash"

  tmux split-window -v -l 10 -t "$1":platform
  tmux send-keys -t "$1":platform.3 "cd ~/dev/repos/dev/platform/devenv" Enter
  tmux send-keys -t "$1":platform.3 "docker exec -it devenv_couchbase_1 bash"

  tmux split-window -v -l 10 -t "$1":platform
  tmux send-keys -t "$1":platform.4 "cd ~/dev/repos/dev/platform/devenv" Enter
  tmux send-keys -t "$1":platform.4 "docker exec -it devenv_apache_1 bash"

  tmux select-pane -t "$1":platform.1
}

alias plug.work.migrations="work_migrations"

work_migrations() {
  tmux new-window -t "$1" -n migrations
  tmux send-keys -t "$1":migrations "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":migrations "cd ~/dev/repos/dev/migrations" Enter
  tmux send-keys -t "$1":migrations "vim" Enter

  tmux split-window -v -l 14 -t "$1":migrations
  tmux send-keys -t "$1":migrations.2 "cd ~/dev/repos/dev/migrations" Enter
  tmux send-keys -t "$1":migrations.2 "psql -U postgres -h localhost"

  tmux select-pane -t "$1":migrations.1
}
  
alias plug.work.work="work_work"

work_work() {
  tmux new-window -t "$1" -n work
  tmux send-keys -t "$1":work "printf '\033]2;%s\033\\' '$1'; '$@';" Enter
  tmux send-keys -t "$1":work "cd ~/projects/work" Enter
  tmux send-keys -t "$1":work "vim" Enter

  tmux split-window -v -l 14 -t "$1":work
  tmux send-keys -t "$1":work.2 "cd ~/projects/work" Enter

  tmux select-pane -t "$1":work.1
}




