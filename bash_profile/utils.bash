
alias grep="grep --exclude=\*.swp --exclude-dir node_modules --exclude-dir '.build' --exclude-dir '.sass-cache'"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

##### Command History (FZF)

# fh - repeat history
runcmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>' ; }

fh() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

fhe() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}


# Another CTRL-R script to insert the selected command from history into the command line/region
#__fzf_history ()
#{
    #builtin history -a;
    #builtin history -c;
    #builtin history -r;
    #builtin typeset \
        #READLINE_LINE_NEW="$(
            #HISTTIMEFORMAT= builtin history |
            #command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
            #command sed '
                #/^ *[0-9]/ {
                    #s/ *\([0-9]*\) .*/!\1/;
                    #b end;
                #};
                #d;
                #: end
            #'
        #)";

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

#builtin set -o histexpand;
#builtin bind -x '"\C-x1": __fzf_history';
#builtin bind '"\C-r": "\C-x1\e^\er"'


# Simple calculator
function calc() {
    local result="";
    result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
    #                       └─ default (when `--mathlib` is used) is 20
    #
    if [[ "$result" == *.* ]]; then
        # improve the output for decimal numbers
        printf "$result" |
        sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
            -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
            -e 's/0*$//;s/\.$//';  # remove trailing zeros
    else
        printf "$result";
    fi;
    printf "\n";
}

# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8";
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# UTF-8-encode a string of Unicode symbols
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
    # print a newline unless we’re piping the output to another program
    if [ -t 1 ]; then
        echo ""; # newline
    fi;
}

function html2md() {
  local dir="$1"
  for file in $(find "$dir" -name "*.html"); do 
    pandoc -f html -t markdown "${file}" -o "${file%html}md"; 
  done

  find "$dir" -type f -name "*.html" | xargs rm
}

