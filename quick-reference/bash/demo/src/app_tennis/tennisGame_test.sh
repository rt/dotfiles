#! /usr/bin/env bash
 
function testItCanProvideAllTheScores () {
  cd src/app_tennis/
  ./tennisGame ./input.txt > ./results.txt
  diff ./output.txt ./results.txt
  assertTrue 'Expected output differs.' $?
}
 
. shunit2
