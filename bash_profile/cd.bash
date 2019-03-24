##### cd 


# Easier navigation: .., ..., ...., ....., -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@";
} 



