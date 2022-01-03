#!/bin/bash

# Initial idea https://unix.stackexchange.com/a/151488.
# https://www.xmodulo.com/tcp-udp-socket-bash-shell.html

# Help section (https://www.redhat.com/sysadmin/arguments-options-bash-scripts)
Help()
{
    # Help message
    echo -e "To start scanning to see which ports are open, do the following. \n"
    echo -e "Syntax: port-list.sh 22,443,...\n\n"
    echo "      -h     For help or detail on how to use the command."
    echo "      -a     For performing a scan on all ports from 0-65535."
}

All()
{
    # Port scan from 0-65535
    for port in {0..65535}; do
        scan_all=$(echo 2>&1 >/dev/tcp/localhost/$port)
        if [[ -z "$scan_all" ]]; then
            echo "$port is open."
        else
            echo "$port is closed."
        fi
    done
}

# Main

while getopts ":ha" option; do
   case $option in
      h) # display Help
      Help
      exit;;
      a) # Scans all ports
      All
      exit;;
      \?) # Invalid option
      echo "Error: Invalid option. Use '-h' option to see how to use the shell script."
      exit;;
   esac
done

# Working with arrays in bash https://opensource.com/article/18/5/you-dont-know-bash-intro-bash-arrays. And replacing without using sed https://stackoverflow.com/a/30021851.
ports=$1
ports="${ports//,/ }"
# echo $ports

for port_number in ${ports[@]}; do
    # If there is no stderr then port is open. https://stackoverflow.com/a/12137501. How to pipe stderr to stdout https://stackoverflow.com/a/2342841.
    cmd=$(echo 2>&1 >/dev/tcp/localhost/$port_number)
    # Bash conditional Expressions https://stackoverflow.com/a/30021851.
    if [[ -z "$cmd" ]]; then
        echo "$port_number is open."
    else
        echo "$port_number is closed."
    fi
done
