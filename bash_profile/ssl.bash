
# param filename.crt
view_cert() {
  openssl x509 -text -noout -in "$1"
}

# Show all the names (CNs and SANs) listed in the SSL certificate for a given domain
# @param example.com
function get_cert_names() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified.";
        return 1;
    fi;

    local domain="${1}";
    echo "Testing ${domain}…";
    echo ""; # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_header, no_serial, no_version, \
            no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
        echo "Common Name:";
        echo ""; # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
        echo ""; # newline
        echo "Subject Alternative Name(s):";
        echo ""; # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
        return 0;
    else
        echo "ERROR: Certificate not found.";
        return 1;
    fi;
}

# function add_self_signed_cert() {
  # probably possible to grab this by hitting the server

  # example (self-signed: gitlab.pebblefields.com.crt)
  # copy or get the contents and put in /usr/local/share/ca-certificates/ 

  # cat gitlab.pebblefields.com.crt > /usr/local/share/ca-certificates/gitlab.pebblefields.com.crt
  # update-ca-certificates

  # that will create it in /etc/ssl/certs/ as a official name ie. /etc/ssl/certs/ca-cert-gitlab.pebblefields.com.pem
# }



# create self-signed with config file
# openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout 192.168.86.22.key -out 192.168.86.22.crt -config req.cnf -sha256
# openssl x509 -text -noout -in 192.168.86.22.crt



# @param ip:port (ie 192.168.86.22:443)
# @param file.crt
function get_remote_cert() {
  openssl s_client -connect $1 -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d' | tee $2 >/dev/null
}


alias ssl.ssh-keygen="ssh-keygen" #ssh-keygen uses openssl and is the default way to create pubkey auth (~/.ssh)

alias ssl.cert.view="view_cert"
alias ssl.cert.getDomainNames="get_cert_names"
alias ssl.cert.getRemoteCert="get_remote_cert"
