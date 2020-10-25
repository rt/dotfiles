

function isGreaterEqualToFive() {
	if [ $1 = 5 ]; then
    return 0
  else
    return 1
  fi
}

function areBothParamsFive() {
  local answer=
	if [ $1 = 5 -a $2 = 5 ]; then
    answer="BOTH"
  elif [ $1 = 5 -o $2 = 5 ]; then
    answer="ONE"
  fi

  echo "$answer"
}

# string
function isYesNoString () {
  # length of string is 0
	if [ -z "$1" ]; then
		echo "EMPTY" >&2
    return 1 # use return in functions (exit in applications/scripts)
		#exit 1
	fi

	if [ "$1" = "yes" ]; then
		echo "YES"
	elif [ "$1" = "no" ]; then
		echo "NO"
  else
    echo "Something else"
	fi
}

# number
function isEven() {

  if [ -z "$1" ]; then
    echo "EMPTY" >&2
    return  1
  fi

  if [ $1 -eq 0 ]; then
    echo "ZERO"
  else
    if [ $1 -lt 0 ]; then
      echo "NEG"
    elif [ $(($1 % 2)) -eq 0 ]; then
      echo "EVEN"
    fi
  fi 
}

# files

function isFile() {
  if ! [ -e "$1" ]; then
    echo "NOT EXIST" >&2
    return  1
  fi

  if [ -f "$1" ]; then
    echo "FILE"
  elif [ -d "$1" ]; then
    echo "DIRECTORY"
  fi
}

##### use modern [[ ]] enhanced version

#allow patter matching, same as path expansion
function isTextFilenameModern() {
  
	if [[ $1 == *.txt ]]; then
    echo "TEXTFILE"
  else
    echo "OTHER"
  fi
  
  #[[ $1 == *.txt ]] && echo "TEXTFILE" || echo "OTHER"
}

#also allows regex on strings
function isNumberModern() {
  local re='^[0-9]+$'
  if ! [[ $1 =~ $re ]]; then
    echo "error: not a number" >&2
    return 1
  else
    echo "NUMBER"
  fi
}

##### and, use (( )) for integers (==, >, <, >=, <=, &&, ||, !) more natural looking
##### Arithmetic Evaluation And Expansion
# $(( )) is related to (( ))
# note (( x = 5 )) is assignment and (( x == 5 )) is test
# +=, -=, etc are supported, and ++, -- pre/post assignment, usually pre ++foo is the expected behavior
function isEvenModern() {

  local num=$1
  if (( num == 0 )); then # interesting you dont need $ to expand (reference?)
    echo "ZERO"
  else
    if (( num < 0 )); then
      echo "NEG"
    elif (( ((num % 2)) == 0)); then
      echo "EVEN"
    fi
  fi
}

#function xxx() {
	
	# Number Bases (shell supports)
	#echo $((0xff))
	#echo $((2#11111111))

	# bit operations (~, <<, >>, &, |, ^)
  #for ((i=0;i<8;++i)); do echo $((1<<i)); done

	# logic (<=, >=, <, >, ==, !=, &&, ||, expr1?expr2:expr3)
	# 1 is true, 0 is false
#}

#also can group wih parenthesis for execution order
function areBothParamsFiveModern() {
  local answer=
  if (( $1 == 5 && $2 == 5 )); then
    answer="BOTH"
  elif (( $1 == 5 || $2 == 5 )); then
    answer="ONE"
  fi

  echo "$answer"
	
  # also use parens to group
  #if [[ ! (INT -ge MIN_VAL && INT -le MAX_VAL) ]]; then
}

	
# case patterns matched by case are the same as those for pathname expansion followed by )
#a)
#[[:alpha:]])
#???)
#*.txt)
#*)
#can also use | for or
#q|Q)
function showFileType() {
  case $1 in

    *.txt)	
      echo "TEXT"
      ;;
    
    *.md) 
      echo "MARKDOWN"
      ;;

  esac
}

function dumbWhileLoop() {
  local breakEarly=$1
	local count=0
  local ret=
  #while [ $count -le 5 ]; do
  while (( count <= 5 )); do 
    if [ "$breakEarly" = true -a "$count" = 2 ]; then
    #if (( breakEarly && count == 2 )); then # hmm, whats wrong with this?
      break;
		fi
		
    #count=$(($count + 1))
    ((++count))
  done
  echo $count
}

#function dumbUntilLoop() {
	#local count=1
  #local ret=
	#until [ $count -gt 5 ]; do
    #echo "hello"
	#done
  #echo $ret
#}


