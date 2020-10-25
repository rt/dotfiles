#! /usr/bin/env bash
 
source src/scripting/functions.sh

### Setup
tmpFile=src/scripting/tmp.txt
touch $tmpFile
> $tmpFile # clear

rm -rf src/scripting/dir
mkdir src/scripting/dir
touch src/scripting/dir/file{1,2}.txt


function testConditional() {

  isGreaterEqualToFive 5
  assertEquals 0 $?

  isGreaterEqualToFive 7
  assertEquals 1 $?
	
}

function testAreBothParamsFive() {
  assertEquals "BOTH" "$(areBothParamsFive 5 5)"
  assertEquals "ONE" "$(areBothParamsFive 4 5)"
  assertEquals "ONE" "$(areBothParamsFive 5 4)"
}

function testIsYesNoString () {
  
  assertEquals 'YES' "$(isYesNoString yes)"
  assertEquals 'NO' "$(isYesNoString no)"

  assertEquals '' "$(isYesNoString '')"
  #because its send to stderr
  assertEquals 'EMPTY' "$(isYesNoString '' 2>&1)"
}

function testIsEven () {
  
  assertEquals 'NEG' "$(isEven -1)"
  assertEquals 'ZERO' "$(isEven 0)"
  assertEquals 'EVEN' "$(isEven 10)"

  assertEquals '' "$(isEven )"
  #because its send to stderr
  assertEquals 'EMPTY' "$(isEven  2>&1)"
}

function testIsFile () {
  
  assertEquals 'FILE' "$(isFile $tmpFile)"
  assertEquals 'DIRECTORY' "$(isFile "src/scripting")"

  assertEquals '' "$(isFile )"
  #because its send to stderr
  assertEquals 'NOT EXIST' "$(isFile  2>&1)"
}

function testIsTextFilename () {
 
  assertEquals 'TEXTFILE' "$(isTextFilenameModern 'something.txt')"
  assertEquals 'OTHER' "$(isTextFilenameModern 'something.md')"

}

function testIsNumber () {
  
  assertEquals 'NUMBER' "$(isNumberModern 10)"

  assertEquals '' "$(isNumberModern )"
  #because its send to stderr
  assertEquals 'error: not a number' "$(isNumberModern  2>&1)"
}

function testIsEvenModern () {
  
  assertEquals 'NEG' "$(isEvenModern -1)"
  assertEquals 'ZERO' "$(isEvenModern 0)"
  assertEquals 'EVEN' "$(isEvenModern 10)"

  #assertEquals '' "$(isEvenModern )"
  ##because its send to stderr
  #assertEquals 'EMPTY' "$(isEvenModern  2>&1)"
}

function testAreBothParamsFiveModern() {
  assertEquals "BOTH" "$(areBothParamsFiveModern 5 5)"
  assertEquals "ONE" "$(areBothParamsFiveModern 4 5)"
  assertEquals "ONE" "$(areBothParamsFiveModern 5 4)"
}

function testShowFileType() {
  assertEquals "TEXT" "$(showFileType something.txt)"
  assertEquals "MARKDOWN" "$(showFileType something.md)"
}

function testWhileLoop() {
  assertEquals 2 "$(dumbWhileLoop true)"
  assertEquals 6 "$(dumbWhileLoop false)"

	#until [ $count -gt 5 ]; do
		#..
	#done
}

function testForLoop() {

  local val=
  for i in A B C D; do
    val=$val$i
  done
  assertEquals 'ABCD' "$val"

	##brace expansion
  val=
	for i in {A..D}; do
    val=$val$i
  done
  assertEquals 'ABCD' "$val"

	#pathname expansion
  val=
	for i in src/scripting/dir/file*.txt; do
    val=$val$i
  done
  assertEquals 'src/scripting/dir/file1.txtsrc/scripting/dir/file2.txt' "$val"

  function strings() {
    echo one two
  }
  #command substitution
  val=
	for i in $(strings); do 
    val=$val$i
  done
  assertEquals 'onetwo' "$val"

}

###### c language form now in bash, if you need numeric sequence

function testCLangForm() {
  val=
	for (( i=0; i<5; i=i+1 )); do
    val=$val$i
	done
  assertEquals '01234' "$val"
}

##### Arrays

#underutilized bc origin unix sh didn't have arrays

function testCreation() {
	#created automatically
	a[1]=foo
	a[3]=bar
  assertEquals "foo" "${a[1]}"
  assertEquals "bar" "${a[3]}"
}

function testCreationWithDeclare() {
  #can also declare
  #multiple assignment
  declare -a a=(foo bar)
  assertEquals "foo" "${a[0]}"
  assertEquals "bar" "${a[1]}"


  #or separately, random
  declare -a a1
  a1=([0]=foo [3]=bar)
  assertEquals "foo" "${a1[0]}"
  assertEquals "bar" "${a1[3]}"
}

function testGetEntireArray() {
  declare -a a=('hello' 'there')

  assertEquals 'hello there' "${a[*]}"

  count=0
  for element in "${a[@]}"; do
    case $count in
      0)
        assertEquals 'hello' "$element"
        ;;
      1)
        assertEquals 'there' "$element"
        ;;
    esac
    ((++count))
  done
  
  assertEquals 2 "${#a[@]}"
}

function testExtration() {
  
  declare -a a=('apple' 'banana' 'orange' 'grapes')

  sub=(${a[@]:1:2}) #put in array, notice the parenthesis
  assertEquals 2 "${#sub[@]}"
  assertEquals 'banana' "${sub[0]}"
  assertEquals 'orange' "${sub[1]}"
}

testAddRemoveElement() {
  declare -a a=('apple' 'banana' 'orange' 'grapes')
  #add
  a=("${a[@]}" 'lemon')
  assertEquals 'apple banana orange grapes lemon' "${a[*]}"
  assertEquals 'lemon' "${a[4]}"

  #remove 
  unset a[4]
  assertEquals 'apple banana orange grapes' "${a[*]}"
  unset a[0]
  assertEquals 'banana orange grapes' "${a[*]}"
  assertEquals 3 "${#a[@]}"
}

function testAddArrays() {
  declare -a a=('aa' 'bb')
  a+=('cc' 'dd')
  assertEquals 'aa bb cc dd' "${a[*]}"
  
  # can also do 
  declare -a a1=('aa' 'bb')
  declare -a a2=('cc' 'dd')
  declare -a a3=(${a1[@]} ${a2[@]})
  assertEquals 'aa bb cc dd' "${a3[*]}"

}

function testSearchAndReplace() {

  declare -a a=('apple' 'banana' 'orange' 'grapes')
  local sub=(${a[@]/banana/watermelon})
  assertEquals 'apple watermelon orange grapes' "${sub[*]}"
  assertEquals 'watermelon' "${sub[1]}"

  #remove with pattern
  local without=(${a[@]/bana*/})
  assertEquals 'apple orange grapes' "${without[*]}"
}

function testReadFileIntoArray() {

  echo "apple banana" > $tmpFile
  declare -a a=($(cat "$tmpFile"))
  assertEquals 'apple banana' "${a[*]}"
  assertEquals 2 "${#a[@]}"

}

function testDeleteArray() {
  declare -a a=('aa' 'bb')
  unset a
  assertEquals '' "${a[*]}"
}

function testSubscripts() {
  declare -a a=('aa' 'bb')
  assertEquals '0 1' "${!a[*]}"
	#${!a[@]} 

}

function testSortArray() {
  #sort array (nifty way to process array)
  a=(f e d c b a)
  a_sorted=($(for i in "${a[@]}"; do echo $i; done | sort))
  assertEquals 'a b c d e f' "${a_sorted[*]}"
}



## Call and Run all Tests
. shunit2
