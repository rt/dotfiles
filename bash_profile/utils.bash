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
alias utils.flushDns="flushDnsMac"
alias utils.digga="digga"



# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

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


function flushDnsMac() {
  sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
}

function restartNic() {
  sudo ifconfig $1 down
  sudo ifconfig $1 up
}

function showResolveConf() {
  cat /etc/resolv.conf
}

