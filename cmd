#!/bin/bash

cmd_USERNAME="user"
cmd_HOSTNAME="host"

cmd_eval () {
case $1 in
    add)
        sum=0
        for i in ${@:2}; do
            let sum+=$i
        done
        echo $sum
        ;;
    echo)
        echo ${@:2}
        ;;
    for)
        for (( i=0; i<$2; i++ )); do
            cmd_eval ${@:3}
        done
        ;;
    ls)
        ls ${@:2}
        ;;
    exit)
        return 1
        ;;
    *)
        echo "Command ${1} not recognized!"
        ;;
esac
}


while true; do



echo -n "${cmd_USERNAME}@${cmd_HOSTNAME} -- > "
read cmd_INPUTSTRING
cmd_COMMAND=( $cmd_INPUTSTRING )
cmd_eval ${cmd_COMMAND[@]} || break



done
