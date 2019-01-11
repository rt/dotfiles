#! /usr/bin/env bash

notes='/Users/rtsunoda/projects/playground/work/filters_and_interceptors.md'
webAppInitializer='/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/java/com/ezrez/corewebapp/WebAppInitializer.java'
filtersDir='/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/java/com/ezrez/corewebapp/filter'
interceptorsPath='/Users/rtsunoda/dev/repos/dev/webapp-spring'

#find "$dirList" -regex "*\(|.md|.java\)" 
declare -a filters=($(find "$filtersDir"))

declare -a interceptors=($(find "$interceptorsPath" -name *Interceptor.java))
  
declare -a all=($notes $webAppInitializer ${filters[@]} ${interceptors[@]})

#a_sorted=($(for i in "${a[@]}"; do echo $i; done | sort))

for element in "${all[@]}"; do
  echo $element
done

