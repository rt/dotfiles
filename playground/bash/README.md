# README #

For messing around with linux.

* Bash scripting that can be unit tests is in `src/`
* Other system stuff is in `exercises/` 

## Run Tests

Run app tests
```
./run_tests app
```

Run all tests
```
./run_tests
```

### Dependencies

- shUnit2

### Handy commands

get base64 representation
```
echo -n 'your-text' | openssl base64
```

### debugging/tracing

	#trace with -x and this will output all the expansions
	#!/bin/bash -x

the contents of the -x option is in the PS4 variable, we can configure to make more usefull

	export PS4='$LINENO + '

can turn on trace dynamically
	
	set -x #turn on tracing



#### Exotica

	#group commands
	{ command1; command2; [command3; ...] }   #group command, requires space
	(command1; command2; [command3; ...])			#subshell
	
	{ ls -l; echo "Listing of foo.txt"; cat foo.txt; } > output.txt
	(ls -l; echo "Listing of foo.txt"; cat foo.txt) > output.txt  

	... | lpr

	#process substitution for processes that produce standard output
	<(list)
	>(list) for processes that intake standard input
	
	read < <(echo "foo")     #tread output of subshell as ordinary file
	
	often used with loops that read

	while read attr links owner group size date time filename; do
		cat <<- EOF
			Filename: $filename
			Size: $size
			Owner: $owner
			Group: $group
			Modified: $date $time
			Links:	$links
			Attributes: $attr
		EOF
	done < <(ls -l | tail -n +2)


