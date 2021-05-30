#! /usr/bin/env bash
 
source src/app_convert_static_website/functions.sh

### Setup

function testGetDomain () {

  # http
  assertEquals 'tldp.org' "$(getDomainFrom http://tldp.org/LDP/Bash-Beginners-Guide/html/index.html)" 

  # https
  assertEquals 'tldp.org' "$(getDomainFrom https://tldp.org/LDP/Bash-Beginners-Guide/html/index.html)" 
}

## Call and Run all Tests
. shunit2
