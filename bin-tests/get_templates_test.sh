#! /usr/bin/env bash
 
# source bin/vim/get_templates.sh

### Setup

# function testComponents () {
# scripts/components/*
# scripts/controllers/search_results|checkout
  # local path='scripts/components/some_component.js'
  # assertEquals 'some-component.hbs' $(source bin/vim/get_templates.sh $path) 
  
  # path='scripts/components/somecomponent.hbs'
  # assertEquals $(source bin/vim/get_templates.sh $path) 'somecomponent.hbs' 
# }

# core-webapp/src/main/webapp/resources/shopping/templates/search_results|checkout
# function testControllers () {
#   local path='templates/checkout/some_component.hbs'
#   assertEquals $(source bin/vim/get_backing_file.sh $path) 'scripts/controllers/checkout/some_component_controller.js'
#   
#   path='templates/search-results/some_component.hbs'
#   assertEquals $(source bin/vim/get_backing_file.sh $path) 'scripts/controllers/search_results/some_component_controller.js'
# }

## Call and Run all Tests
. shunit2

