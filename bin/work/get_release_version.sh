
format=$1

# Get test for current file
root=~/dev/repos/dev

release=
while read line; do
  if [[ $line = *"<version>"*"</version>"* ]]; then
    release=${line/\<version\>/}
    release=${release/\<\/version\>/}
    #remove white spaces
    release="$(echo -e "${release}" | tr -d '[:space:]')"
    break;
  fi
done <$root/pom.xml

case $format in
  dot)
    major=${release:0:2}
    minor=${release: -1} #must be preceeded by space
    echo "$major.$minor"
    ;;
  *)
    echo "$release"
    ;;
esac

