

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

alias net.ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias net.localip="ipconfig getifaddr en0"
alias net.ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# View HTTP traffic
alias net.sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias net.httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Dns
alias net.flushDns="flushDnsMac"
alias net.digga="digga"
