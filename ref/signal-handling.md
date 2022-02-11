
##### traps (signal handling) good for cleaning up temp files
	# trap argument signal [signal...]

	exit_on_sigint () {
		echo "Script interrupted." 2>&1
	}
	exit_on_sigterm () {
		echo "Script terminated." 2>&1
	}

	trap exit_on_sigint SIGINT
	trap exit_on_sigterm SIGTERM

	for i in {1..5}; do
		echo "Iteration $i of 5"
		sleep 5
	done


