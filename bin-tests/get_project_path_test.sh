#! /usr/bin/env bash
 
### Setup

function testGetPath () {
  local path='aa/bb'
  assertEquals '/Users/rtsunoda/projects/dotfiles/aa/bb' $(source bin/vim/get_project_path.sh $path)
}
. shunit2

