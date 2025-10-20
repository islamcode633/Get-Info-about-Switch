#!/usr/bin/env bash

# Checking SSL certificate support on the host


function generate_sslcert {
    local IP='192.168.127.253:443'
    local green="\e[0;92m"
    local off_color="\e[0m"

    for cipher in $(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g'); do
        [[ $(openssl s_client -cipher "$cipher" -connect "$IP" 2>&1) =~ ":error:" ]] || \
            echo -e "$cipher ${green}[supported]${off_color}"
    done
}

# successfully log in to the host and open HTTPS port 443
generate_sslcert
