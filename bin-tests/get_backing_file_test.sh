#! /usr/bin/env bash
 
# source bin/vim/get_backing_file.sh

### Setup

function testWorkComponents () {
  local path='templates/components/some-component.hbs'
  assertEquals 'scripts/components/some_component.js' $(source bin/vim/get_backing_file.sh $path)
  
  path='templates/components/somecomponent.hbs'
  assertEquals 'scripts/components/somecomponent.js' $(source bin/vim/get_backing_file.sh $path)
}

# core-webapp/src/main/webapp/resources/shopping/templates/search_results|checkout
function testWorkControllers () {
  local path='templates/checkout/some_component.hbs'
  assertEquals 'scripts/controllers/checkout/some_component_controller.js' $(source bin/vim/get_backing_file.sh $path)
  
  path='templates/search-results/some_component.hbs'
  assertEquals 'scripts/controllers/search_results/some_component_controller.js' $(source bin/vim/get_backing_file.sh $path)
}

## Call and Run all Tests
. shunit2

