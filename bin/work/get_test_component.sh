#! /usr/bin/env bash

# This returns the test-c-component path from c-component (js or hbs)

# core-webapp/src/main/webapp/resources/shopping/components/my_component.js
# core-webapp/src/main/webapp/resources/shopping/templates/my-component.hbs
rpath="$1"
rpath=${rpath/components\//components\/test_}
rpath=${rpath/templates\//templates\/test-}

echo $rpath

