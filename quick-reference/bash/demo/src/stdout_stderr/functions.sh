
function getStdoutAndStderr () {

  # direct to stderr
  echo "Error ..." 1>&2

  # stdout
  echo "Output ..."

  # I can do this in shUnit2 otherwise it fails (maybe `set -e` is in affect?)
  #exit 1 
}

