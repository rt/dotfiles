#! /usr/bin/env bash
 
source src/stdout_stderr/functions.sh

### Setup
tmpFile=src/stdout_stderr/tmp.txt
touch $tmpFile
> $tmpFile # clear
 
# note stderr will still go to console even on redirection
function testNoSuppression () {

  assertEquals 'Output ...' "$(getStdoutAndStderr)"

  assertEquals '' "$(getStdoutAndStderr > $tmpFile)"
  assertEquals 'Output ...' "$(< $tmpFile)"
  
}

function testSuppressStdErr () {
  # suppress stderr
  assertEquals 'Output ...' "$(getStdoutAndStderr 2> /dev/null)"
  
  # suppress stderr but redirect to file
  assertEquals 'Output ...' "$(getStdoutAndStderr 2> $tmpFile)"
  assertEquals 'Error ...' "$(< $tmpFile)"

}

function testSuppressBoth() {
  # suppress both stdout and stderr
  assertEquals '' "$(getStdoutAndStderr &> /dev/null)"

  # suppress both stdout and stderr (another syntax)
  assertEquals '' "$(getStdoutAndStderr > /dev/null 2>&1)"
}

function testTee() {
  # tee will output to terminal and save to file
  assertEquals 'Output ...' "$(getStdoutAndStderr | tee $tmpFile)"
  assertEquals 'Output ...' "$(< $tmpFile)"
}

## Call and Run all Tests
. shunit2
