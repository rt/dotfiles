# Find a file 

Finding a file fast depends on the size of the repo/directory. Usually, you are
narrowing the search range by repo or directory. Frequent searches can be dones
with set queries.  Queries also can be useful if searching cross-directory.

*git repo*
- `:GFiles`                  : Simple but might have to type a lot on large code bases

*directory*
- `:lcd` > `:Files`           : Limit the scope but still flexible to go to any directory, or easy to do cwd
- `custon_query.sh` > `fzh` : Limit to subset of project-wide query

*queries*
args `find ~/dev/repos/dev/ -name build.gradle -maxdepth 2`
args `find ~/dev/repos/dev/ -name pom.xml -maxdepth 2`
args `find ~/dev/repos/dev/core-webapp/src/main/webapp/resources/ -name package.json -maxdepth 2`
args `find ~/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping/scripts/liquid/models/ -name \*.js`
