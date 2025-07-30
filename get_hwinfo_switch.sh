#!/bin/sh

# The simply script get info about Switch
# INFO: eth interfaces/mountpoints/hostname/disk space/ and etc...


exec_cmds() {
    # Execution of commands to collect information about the switch with output to stdout

    for cmd in "$@"; do
        echo "Command: [ $cmd ]"
        echo "-- Data block: --"
            $cmd
        echo -e "-- End --\n"
        sleep 10
    done
}


case "$1" in
    '-h'|'--help')
        help='Go to the Linux command shell on the switch and \
    make the file executable and after run ./get_hwinfo_switch.sh'
        eval "echo $help ; exit 1"
        ;;
    *)
        exec_cmds 'uname -a' 'id' 'hostname' 'env' \
            'blkid' 'mount' 'fdisk -l' 'df -h' 'free' \
            'ip a' 'route' 'lsusb' \
            'lsmod' 'lsof' \
            'ps'
        ;;
esac
