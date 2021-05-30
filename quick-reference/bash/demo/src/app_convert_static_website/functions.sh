
function website2md() {
  domain=$(getDomainFrom $1)
  wget --recursive --convert-links --no-parent $1

  for file in $(find "$domain" -name "*.html"); do 
    pandoc -f html -t markdown "${file}" -o "${file%html}md"; 
  done

  find "$domain" -type f -name *.html | xargs rm

  find "$domain" -type f -name *.md -exec sed -i '' 's/\.html/.md/g' {} \;
}

function getDomainFrom() {
  local url=$1

  # remove from beginning
  local part1=${url#http://}
  #echo "part1:$part1"

  # remove from beginning
  local part2=${part1#https://}
  #echo "part2:$part2"


  IFS='/' read domain other <<< "$part2"
  echo "$domain"

  #IFS='/' read -ra parts <<< $part2
  #"set --" splits $parts at the $IFS character (by default space) and assigns the split parts to the positional variables 
  #set -- $parts 
  #echo $1

}



