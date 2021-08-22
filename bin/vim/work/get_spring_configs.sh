#! /usr/bin/env bash

notes='/Users/rtsunoda/projects/playground/work/spring_application_context.md'
webAppInitializer='/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/java/com/ezrez/corewebapp/WebAppInitializer.java'
#corewebapp='/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/java/com/ezrez/corewebapp/config'

#find "$dirList" -regex "*\(|.md|.java\)" 
#declare -a filters=($(find "$filtersDir"))

#declare -a configs=($(git ls-files *Config.java))
declare -a configs=($(git grep -l "@Configuration"))
  
declare -a all=($notes $webAppInitializer ${configs[@]})

#a_sorted=($(for i in "${a[@]}"; do echo $i; done | sort))

for element in "${all[@]}"; do
  echo $element
done

