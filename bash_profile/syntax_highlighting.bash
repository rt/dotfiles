##### Terminal Syntax Highlighting

# Pipe Highlight to less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-light"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'

# Use "highlight" in place of "cat"
alias cat="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style solarized-light"

