#!/bin/bash

cmd_eval () {
case $1 in
    add)
        sum=0
        for i in ${@:2}; do
            let sum+=$i
        done
        echo $sum
        ;;
    multiply)
        product=1
        for i in ${@:2}; do
            let product*=$i
        done
        echo $product
        ;;
    cd)
        cd ${@:2}
        ;;
    echo)
        echo ${@:2}
        ;;
    for)
        for (( i=0; i<$2; i++ )); do
            cmd_eval ${@:3}
        done
        ;;
    help)
        echo "commands:   add"
        echo "            cd"
        echo "            echo"
        echo "            for"
        echo "            help"
        echo "            ls"
        echo "            exit"
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



echo -n "${PWD##*/} > "
read cmd_INPUTSTRING
cmd_COMMAND=( $cmd_INPUTSTRING )
cmd_eval ${cmd_COMMAND[@]} || break



done
