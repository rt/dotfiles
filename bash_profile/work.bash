export DB_DATA_DIR=postgresql
export GRADLE_OPTS='-Xms3G -Xmx3G -verbose:gc'
alias gradlew='~/dev/repos/dev/gradlew'

ctags_switchfly() {
  ctags -R --language-force=java -f tags core-webapp/src/ webapp-spring/src/ webcf/src/ web-common/src/ core/src/ common/src/
}


alias wpl="find ~/dev/repos/dev/core-webapp/src/main/webapp/resources/ -name package-lock.json -maxdepth  2 | xargs rm"
alias wnm="find ~/dev/repos/dev/core-webapp/src/main/webapp/resources/ -name node_modules -maxdepth  2 -type dir | xargs rm -rf"


work_clear_coverage() {
  cd ~/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping/scripts 
  rm -rf coverage HeadlessChrome*
  rm *.xml
  cd -
}


alias wps="ant package.all.shopping"
alias wmi="mvn clean install -Pdependencies -DskipTests"
alias wmit="mvn clean install -Pdependencies -T2 -DforkCount=2" #need 4 databases
alias waa="ant all"

alias workBuildXml="less ~/dev/repos/dev/build.xml"
alias workJenkinsfile="less ~/dev/repos/dev/Jenkinsfile"
alias workPomXml="less ~/dev/repos/dev/pom.xml"
alias workEzrezLocalProperties="less ~/dev/repos/dev/common/src/main/resources/ezrez.local.properties"

#alias gLog="git log | grep rtsunoda -B 1 -A 3 | head -n 50"
alias gLog="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gLog2="git --no-pager log --oneline --all --decorate --graph -40 --pretty=format:'%h %ad | %s%d [%an]'"

