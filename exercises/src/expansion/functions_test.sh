#! /usr/bin/env bash
 
source src/expansion/functions.sh

### Setup
rm -rf src/expansion/dir
mkdir src/expansion/dir
touch src/expansion/dir/file{1,2}.txt

function testExpansion () {

  local count=0
  while IFS= read -r line
  do
    # display $line or do somthing with $line
    printf '%s\n' "$line"
    case $count in
      0)
        assertEquals "$HOME" "$line"
        ;;
      1)
        assertEquals 'src/expansion/dir/file1.txt src/expansion/dir/file2.txt' "$line"
        ;;
      2)
        assertEquals '1' "$line"
        ;;
      3)
        assertEquals '2' "$line"
        ;;
      4)
        assertEquals '1 2 3' "$line"
        ;;
      5)
        assertEquals 'something' "$line"
        ;;
    esac

    count=$((count+1))
  done < "$(expansion)"
}

# expands parameters
function testVarInDoubleQuotes() {
  local var=1
  assertEquals "$var" '1'
}

# expands arithmetic
function testArithmaticInDoubleQuotes() {
  assertEquals "$((1 + 1))" '2'
}

# doesn't expand paths
function testPathInDoubleQuotes() {
  assertEquals "~" '~'
  assertEquals "src/expansion/dir/*" 'src/expansion/dir/*'
}

# doesn't expand braces
function testBraceInDoubleQuotes() {
  assertEquals "{1,2,3}" '{1,2,3}'
}

# single quotes suppress all

function testVarInSingleQuotes() {
  local var=1
  assertEquals '$var' "\$var" #notice i do the reverse here, escape \$ in double quotes 
}

function testArithmaticInSingleQuotes() {
  assertEquals '$((1 + 1))' "\$((1 + 1))"
}

# same as double quotes
function testPathInSingleQuotes() {
  assertEquals '~' "~"
  assertEquals 'src/expansion/dir/*' "src/expansion/dir/*"
}

# same as double quotes
function testBraceInSingleQuotes() {
  assertEquals '{1,2,3}' "{1,2,3}"
}

#####parameter expansion
function testConditionalParameterExpansion() {

  # ":" can be omitted if just checkout unset but ":" will treat empty as unset which is more common i think

  #substitue value (doens't change foo)
	assertEquals 'substitute value if unset' "${foo:-substitute value if unset}"
  assertEquals "" "$foo" 

	#default value (also sets foo}
  echo ${foo:="default value if unset"}
  assertEquals "default value if unset" "${foo:=default value if unset}"
  assertEquals "default value if unset" "$foo"
  
  #substitue if value is set
  foo='something'
	assertEquals 'substitute value if set' "${foo:+substitute value if set}"
  assertEquals "something" "$foo" 

  #exit with error message (cant test this here because it will exit)
  unset foo
  #assertEquals "has error" "${foo:?has error}"

}

function testRemove() {
  local param=basketball

	#remove preceeding part defined by pattern
	#${parameter#pattern}
  assertEquals 'ball' "${param#basket}"

  local foo=file.txt.zip
  assertEquals 'txt.zip' ${foo#*.}

	#${parameter##pattern} #removes the longest match
	assertEquals 'zip' ${foo##*.}
	
	##remove from the end
	#${parameter%pattern}
  assertEquals 'basket' "${param%ball}"
}


testSearchAndReplace() {

  local param=basketball
	#${parameter/pattern/string}
  assertEquals 'football' ${param/basket/foot}

  local param1=ballbasketball
	#${param//pattern/string} #global
  assertEquals 'rockbasketrock' ${param1//ball/rock}
  
	#${parameter/#pattern/string} #beginning
  assertEquals 'rockbasketball' ${param1/#ball/rock}

	#${parameter/%patter/string}  #end
  assertEquals 'ballbasketrock' ${param1/%ball/rock}
}

function testParamLength () {

  local param=hello

  assertEquals '5' "${#param}"

	#length (if parameter is @ or *, expansion results in the number of positional parameters)
  set foo bar
  assertEquals '2' "${#*}"
  assertEquals '2' "${#@}"

}

function testOffset () {
	
  local param=basketball
	#${param:offset}
	assertEquals 'ball' "${param:6}"

	#${param:offset:length}
	assertEquals 'ket' "${param:3:3}"

	#if negative taken from the end (must be proceeded with space to prevent confusion with the ${param:-word} expansion
	assertEquals 'ball' "${param: -4}"
}



# unquoted here-documents should parameter expand, command substitute, arithmetic expand
function testHereDocumentExpansion () {

  local count=0
  while IFS= read -r line
  do
    # display $line or do somthing with $line
    printf '%s\n' "$line"
    case $count in
      0)
        assertEquals "~" "$line"
        ;;
      1)
        assertEquals 'src/expansion/dir/*' "$line"
        ;;
      2)
        assertEquals '1' "$line"
        ;;
      3)
        assertEquals '2' "$line"
        ;;
      4)
        assertEquals '{1,2,3}' "$line"
        ;;
      5)
        assertEquals 'something' "$line"
        ;;
    esac

    count=$((count+1))
  done < "$doc"
}

# quoted no expansion
function testHereDocumentExpansion () {

  function getSomething() {
    echo "something"
  }
  local var1=1

  local doc <<-"EOF"
	~
	src/expansion/dir/*
	$var1
	$((1 + 1))
	{1,2,3}
	$(getSomething)
EOF


  local count=0
  while IFS= read -r line
  do
    # display $line or do somthing with $line
    printf '%s\n' "$line"
    case $count in
      0)
        assertEquals "~" "$line"
        ;;
      1)
        assertEquals 'src/expansion/dir/*' "$line"
        ;;
      2)
        assertEquals '$var1' "$line"
        ;;
      3)
        assertEquals '$((1 + 1))' "$line"
        ;;
      4)
        assertEquals '{1,2,3}' "$line"
        ;;
      5)
        assertEquals '$(getSomething)' "$line"
        ;;
    esac

    count=$((count+1))
  done < "$doc"
}

## Call and Run all Tests
. shunit2
