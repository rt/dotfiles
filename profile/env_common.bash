export PATH="$HOME/bin:$PATH";
export PATH="$HOME/bin/vim:$PATH";
export PATH="$HOME/bin/vim/work:$PATH";

# Python
export PATH="$HOME/Library/Python/3.8/bin:$PATH";

# Flutter
export PATH="$HOME/projects/flutter/bin:$PATH";

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# NodeJs
export NODE_PATH=/usr/lib/nodejs

# Make vim the default editor
export EDITOR="vim";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto";

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Enable aliases to be sudo’ed
alias sudo='sudo '

# common stuff
alias sp='source ~/.bash_profile'


##### History

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

##### Terminal Syntax Highlighting

# Pipe Highlight to less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style solarized-light"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'

# Use "highlight" in place of "cat"
alias cat="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style solarized-light"


##### Utils
alias utils.calc="calc"
alias utils.dataurl="dataurl"
alias utils.escape="escape"
alias utils.unidecode="unidecode"
alias utils.codepoint="codepoint"
alias utils.html2md="html2md"
alias utils.urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias utils.ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias utils.localip="ipconfig getifaddr en0"
alias utils.ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# View HTTP traffic
alias utils.sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias utils.httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Dns
alias utils.digga="digga"

# $ ping -c4 www.google.com | awk '/---/,0'
# --- www.google.com ping statistics ---
# 4 packets transmitted, 4 packets received, 0.0% packet loss
# round-trip min/avg/max/stddev = 87.110/92.619/98.271/3.955 ms
#
#

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

# Run `dig` and display the most useful info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}

### host is simple utility for DNS lookups
# host -t A google.com

### nslookup look up name server, ip addresses
# nslookup google.com
# nslookup -type=ns
# nslookup -type=mx

# dig google.com mx
# dig google.com ns
# dig google.com a +tcp

### whois is additional information about the domain
# whois google.com
# whois 8.8.8.8
# whois 9.9.9.9

### curl ...
# curl -u user:password -X GET ...

# Hosts file changes shouldn't need network restart


function restartNic() {
  sudo ifconfig $1 down
  sudo ifconfig $1 up
}

function showResolveConf() {
  cat /etc/resolv.conf
}




