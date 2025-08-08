#!/bin/bash -eu
#
# Install vsftpd and base settings FTP server
#


declare -r SERVICE='vsftpd'
declare -i FAILED_START_VSFTPD=1


function install_service_vsftpd {
    [[ $(awk '{print $2}' <(dpkg -l | grep -i $SERVICE)) == "$SERVICE" ]] || {
        apt update
        apt install vsftpd -y
    }
    echo "$SERVICE installed successfully !"
}

function run_service_vsftpd {
    #

    check_state=$(systemctl status $SERVICE | grep -i inactive | awk '{print $2}')
    if [[ "$check_state" == 'inactive' ]]; then
        systemctl start $SERVICE || {
            printf "%s startup error code $? !\n" $SERVICE
            exit $FAILED_START_VSFTPD
        }
    fi
    printf '\nService %s launched successfully !\n' $SERVICE
}

function set_config_in_vsftpd {
    cat < /etc/vsftpd.conf > "$HOME/backup_vsftpd.conf" 
    #for conf_string in 'listen=YES' 'listen_ipv6=NO' 'local_enable=YES' \
    #                    'write_enable=YES' 'connect_from_port_20=YES' \
    #                    'use_localtime=YES' 'xferlog_enable=YES'
    #do
    #    tee "$conf_string" /etc/vsftpd.conf
    #done
}

function flowctl {
    #install_service_vsftpd
    #run_service_vsftpd
    set_config_in_vsftpd 
}

flowctl
