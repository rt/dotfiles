# Tmux Pairing

	#!/bin/sh                                                                                                   
  	sess=pebble-workspace
 
  	tmux -S /tmp/pair new-session -s $sess -d -n terminal
  	tmux -S /tmp/pair new-window -t $sess -n vim
  	tmux -S /tmp/pair send-keys -t $sess:vim "vim" Enter
 	tmux -S /tmp/pair -2 attach-session -t $sess

    //need to do this separate
 	chmod 777 /tmp/pair
    //execute dotfiles for them
	
	...your pair would do
	tmux -2 -S /tmp/pair attach -t pebble-workspace

	//create script to setup env
	#!/bin/sh                                                                                                   
  	sess=pebble
  	tmux new-session -s $sess -d -n pebble-dev
  	tmux send-keys -t $sess:pebble-dev "cd projects/pebble-dev && node app.js" Enter
  	tmux split-window -v t $sess:pebble-dev
  	tmux split-window -h
  	tmux new-window -t $sess -n vim
  	tmux send-keys -t $sess:vim "cd projects/pebble-dev && vim" Enter
 	tmux new-window -t $sess -n automation
 	tmux send-keys -t $sess:automation "cd projects/pebble-dev/automation && mocha test1.js" Enter
 	tmux select-window -t $sess:vim
 	tmux -2 attach-session -t $sess
	
	//or with session files
	//in .tmux.conf
	bind S source-file ~/.tmux/session1
	
	//session1
	new  -s SessionName -n WindowName Command
	neww -n foo/bar foo
	splitw -v -p 50 -t 0 bar
	selectw -t 1 
	selectp -t 0
	
	//set up ssh /etc/ssh/ssh_config > root access

## pairing using your mac (set up ssh key based auth)

- create "pair" user
- Sharing > Remote Login for pair (so people can log in as pair@ip)
- add everybodys id_isa.pub to /Users/pair/.ssh/authorized_keys (each file is one line in authorized_keys)


