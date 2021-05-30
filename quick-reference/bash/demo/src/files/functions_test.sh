#! /usr/bin/env bash
 
#source src/files/functions.sh

### Setup
tmpFile=src/files/tmp.txt
touch $tmpFile
> $tmpFile # clear

function testSplitString() {

  # use IFS and read
  IFS=';' read first second <<< "foo;bar"

  assertEquals 'foo' $first
  assertEquals 'bar' $second

  # use tr
	local IN="foo;bar"

	local arr=$(echo $IN | tr ";" "\n")

  local count=0
	for x in $arr
	do
    case $count in
      0)
        assertEquals 'foo' "$x"
        ;;
      1)
        assertEquals 'bar' "$x"
        ;;
    esac
    count=$((count + 1))
	done
}

function testRenameFiles() {
  rm -rf src/files/dir
  mkdir src/files/dir
  touch src/files/dir/file{1,2}.txt

  # rename isn't on mac
  #find src/files/dir -type f -name *.txt | rename 's/\.txt$/.md/'

  #for file in $(find src/files/dir -type f -name *.txt); do
    #mv $file $(echo $file | sed s/\.txt$/.md/)
  #done

  find src/files/dir -type f -name *.txt -exec bash -c 'mv $0 ${0/.txt/.md}' {} \;
}

#function execScriptOnFiles() {
#find . -name "file" -exec sh /path/to/script.sh {} \;
#}

#function testExpansion () {

  #$(expansion > $tmpFile)

  #local count=0
  ## The -r option passed to read command prevents backslash escapes from being interpreted.
  ## Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed -
  #while IFS= read -r line
  #do
    ## display $line or do somthing with $line
    #printf '%s\n' "$line"
    #case $count in
      #0)
        #assertEquals "$HOME" "$line"
        #;;
      #1)
        #assertEquals 'src/expansion/dir/file1.txt src/expansion/dir/file2.txt' "$line"
        #;;
      #2)
        #assertEquals '1' "$line"
        #;;
      #3)
        #assertEquals '2' "$line"
        #;;
      #4)
        #assertEquals '1 2 3' "$line"
        #;;
      #5)
        #assertEquals 'something' "$line"
        #;;
    #esac

    #count=$((count+1))
  #done < "$tmpFile"
#}


## Call and Run all Tests
. shunit2
