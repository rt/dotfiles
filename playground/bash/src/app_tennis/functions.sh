
function getFirstPlayerFrom () {
  echo $1 | sed -e 's/-.*//'
}

function getSecondPlayerFrom () {
  echo $1 | sed -e 's/.*-//'
}

function getScoreFor () {
  local player=$1
  local standings=$2
  local totalMatches=$(echo "$standings" | grep $player | wc -l)
  # minus 1 because the first line doesn't count
  echo $(($totalMatches-1))
}

function convertToTennisScore () {
  #use associative array for score to tennis score
  #declare -a scoreMap=(['0']='0' ['1']='15' ['2']='30' ['3']='40') 
  #shorthand
  declare -a scoreMap=('0' '15' '30' '40')
  echo ${scoreMap[$1]};
}

 
# check for both scores over 40
function outOfRegularScore () {
  [ $1 -gt 2 ] && [ $2 -gt 2 ]
  return $?
}
 
function checkEquality () {
  if [ $1 -eq $2 ]; then
    echo "Deuce"
  fi
}

function displayScore () {
  # give meaningful names
  local firstPlayerName=$1 
  local firstPlayerScore=$2
  local secondPlayerName=$3
  local secondPlayerScore=$4

  if outOfRegularScore $firstPlayerScore $secondPlayerScore; then
    checkEquality $firstPlayerScore $secondPlayerScore
    checkAdvantageFor $firstPlayerName $firstPlayerScore $secondPlayerScore
    checkAdvantageFor $secondPlayerName $secondPlayerScore $firstPlayerScore
  else
    echo "$1: `convertToTennisScore $2` - $3: `convertToTennisScore $4`"
  fi
}
 
function checkAdvantageFor () {
    if [ $2 -gt $3 ]; then
        if [ `expr $2 - $3` -gt 1 ]; then
            echo "$1: Winner"
        else
            echo "$1: Advantage"
        fi
    fi
}
