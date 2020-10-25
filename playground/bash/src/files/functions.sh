
###### files


	#FILE=/etc/passwd
	#read -p "Enter a user name > " user_name
	#file_info=$(grep "^$user_name:" $FILE)

	#if [ -n "$file_info"]; then

    ##<<< is a here string because you cannot pipe "read", because pipes are
    ##subshells and you wouldn't be able to change env variables

		#IFS=":" read user pw uid gid name home shell <<< "$file_info"
		#echo "user = '$user'"
		#echo "uid = '$uid'"
		#...



###### read std input means we can process files

	##read exits after each line is read until eof where the exits status is non zero which causes while to end
	#while read distro version release; do
		#printf "Distro: %s\tVersion: %s\tReleased: %s\n" \
			#$distro \
			#$version \
			#$release
	#done < distros.text


##### temp files

	tempfile=/tmp/$(basename $0)..$$.$RANDOM

	better way is to use mktemp which accepts a template with series of "X" characters to randomize
	tempfile=$(mktemp /tmp/foobar.$$.XXXXXXXXXXXX)

	$$ > pid

	for regular users (no su), should store in home directory
	[[ -d $HOME/temp ]] || mkdir $HOME/tmp
