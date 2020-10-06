alias grep="grep --exclude=\*.swp --exclude-dir node_modules --exclude-dir '.build' --exclude-dir '.sass-cache'"
alias grep.preview="vgp"


vgp() {
# Try highlight, coderay, rougify in turn, then fall back to cat
  fzf --preview '[[ $(file --mime {}) =~ binary ]] && \
                 echo {} is a binary file || \
                 (highlight -O ansi -l {} || \
                  coderay {} || \
                  rougify {} || \
                  cat {}) 2> /dev/null | head -500'

}

