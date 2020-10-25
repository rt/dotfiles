#! /usr/bin/env bash
 
source src/positional_parameters/functions.sh

### Setup
tmpFile=src/positional_parameters/tmp.txt
touch $tmpFile
> $tmpFile # clear

function testGetPositionalParametersDetails () {

  $(getPositionalParametersDetails foo bar > $tmpFile)

  local count=0
  # The -r option passed to read command prevents backslash escapes from being interpreted.
  # Add IFS= option before read command to prevent leading/trailing whitespace from being trimmed -
  while IFS= read -r line
  do
    # display $line or do somthing with $line
    printf '%s\n' "$line"
    case $count in
      0)
        assertEquals '$0 src/positional_parameters/functions_test.sh' "$line"
        ;;
      1)
        assertEquals '$1 foo' "$line"
        ;;
      2)
        assertEquals '$2 bar' "$line"
        ;;
      3)
        assertEquals '$#:2' "$line"
        ;;
      4)
        assertEquals '$@:foo bar' "$line"
        ;;
      5)
        assertEquals '$*:foo bar' "$line"
        ;;
    esac

    count=$((count+1))
  done < "$tmpFile"
}

function testIterateParametersWith () {
  assertEquals 'foobar' "$(iterateParameters foo bar)"
}

function testIterateParametersWithFor () {
  assertEquals 'foobar' "$(iterateParametersWithFor foo bar)"
}

function testIterateParametersWithBash () {
  assertEquals 'foobar' "$(iterateParametersWithBash foo bar)"
}

function testIterateParametersWithBash () {
  assertEquals 'foobar' "$(iterateParametersWithAt foo bar)"
}

function testUnderstandingAtAndWildcard () {
  understandingAtAndWildcard one two "three four"
}

## Call and Run all Tests
. shunit2
