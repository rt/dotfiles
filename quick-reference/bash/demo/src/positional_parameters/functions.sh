

function getPositionalParametersDetails () {
  for ((i = 0; i <= $#; i++ )); do 
    echo "\$$i ${!i}" 
  done 

  # number of arguments
  echo '$#:'$#
  echo '$@:'$@
  echo '$*:'$*
  echo "FUNCNAME:$FUNCNAME"
  
  echo '$@:'"$@"
}

function iterateParameters () {

  local count=0
  while [[ $# -gt 0 ]]; do
    count=$((count + 1))
    printf "%s" $1
    #$# is decreased by 1 when shift is called and the args shift $2 becomes $1 ...
    shift
  done
}

# This seems to be the simplest, most portable
# Doesnt give you $0, but that is probably good
function iterateParametersWithFor () {
	# defaults to positional parameters (dont have to use shift in many cases)
	for i; do
    printf "%s" $i
  done
}

# ${!i} being an indirect variable expansion, that is expand to the content of
# the parameter whose name is stored in the i variable
function iterateParametersWithBash () { 
  for ((i = 1; i <= $#; i++ )); do 
    printf '%s' "${!i}" 
  done 
}

# feel like this is the best, see understandingAtAndWildcard
function iterateParametersWithAt () { 
  for a in "$@"; do
    printf "%s" $a
  done
}

# see https://unix.stackexchange.com/questions/129072/whats-the-difference-between-and
function understandingAtAndWildcard() {
  
  echo '---- understanding $@ and $*'

  echo "Using \"\$*\":"
  # $*: expands into list starting at $1. when double quoted it will deliminate with IFS shell variable (not useful becase "aa bb" will also be separated out)
  for a in "$*"; do
    echo $a;
  done

  echo  "\nUsing \$*:"
  for a in $*; do
    echo $a;
  done

	# $@: "". when double quoted expands to each word double quoted preserving the quotes used (MOST USEFUL)
  echo  "\nUsing \"\$@\":"
  for a in "$@"; do
    echo $a;
  done

  echo  "\nUsing \$@:"
  for a in $@; do
    echo $a;
  done              
}
