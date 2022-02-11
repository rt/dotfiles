
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


