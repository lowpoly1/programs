#!/bin/bash

cmd_USERNAME="user"
cmd_HOSTNAME="host"


while true; do



echo -n "${cmd_USERNAME}@${cmd_HOSTNAME} -- $ "
read cmd_INPUTSTRING
cmd_COMMAND=( $cmd_INPUTSTRING )
#echo "command: ${cmd_COMMAND[0]}"
case ${cmd_COMMAND[0]} in
    add)
        sum=0
        for i in ${cmd_COMMAND[@]:1}; do
            let sum+=$i
        done
        echo $sum
        ;;
    echo)
        echo ${cmd_COMMAND[@]:1}
        ;;
    ls)
        ls ${cmd_COMMAND[@]:1}
        ;;
    exit)
        break
        ;;
    *)
        echo "Command not recognized!"
        ;;
esac



done
