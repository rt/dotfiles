
##### named pipes

	connect between two processes

	process1 > named_pipe
	process2 < named_pipe

	behaves like
	process1 | process2


	# create
	mkfifo pipe1
	ls -l pipe1

	#need 2 termnials
	ls -l > pipe1

	cat < pipe1

