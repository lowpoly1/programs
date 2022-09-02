#!/bin/bash

cmd_USERNAME="user"
cmd_HOSTNAME="host"


while true; do



echo -n "${cmd_USERNAME}@${cmd_HOSTNAME} -- $ "
read cmd_INPUTSTRING
cmd_COMMAND=( $cmd_INPUTSTRING )
#echo "command: ${cmd_COMMAND[0]}"
case ${cmd_COMMAND[0]} in
    echo)
        echo ${cmd_COMMAND[@]:1}
        ;;
    ls)
        ls ${cmd_COMMAND[@]:1}
        ;;
    add)
        
    exit)
        break
        ;;
    *)
        echo "Command not recognized!"
        ;;
esac



done
