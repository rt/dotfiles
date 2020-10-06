alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# similar to default fzf esc-c
alias cd.fuzzy="fd"


# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Another CTRL-T script to select a directory and paste it into line
#__fzf_select_dir ()
#{
        #builtin typeset READLINE_LINE_NEW="$(
                #command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) \
                        #-prune \
                        #-o -type f -print \
                        #-o -type d -print \
                        #-o -type l -print 2>/dev/null \
                #| command sed 1d \
                #| command cut -b3- \
                #| env fzf -m
        #)"

        #if
                #[[ -n $READLINE_LINE_NEW ]]
        #then
                #builtin bind '"\er": redraw-current-line'
                #builtin bind '"\e^": magic-space'
                #READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                #READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        #else
                #builtin bind '"\er":'
                #builtin bind '"\e^":'
        #fi
#}

#builtin bind -x '"\C-x1": __fzf_select_dir'
#builtin bind '"\C-t": "\C-x1\e^\er"'

