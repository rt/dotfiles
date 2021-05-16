alias mkdir.into="mkd"

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@";
} 
