#!/bin/bash

declare -A cmd_VARIABLES
declare -a cmd_PARAMETERS
declare cmd_INPUTSTRING
declare cmd_COMMAND

cmd_eval () {


#variable expansion
for i; do
    if [[ ${i::1} == "\$" ]]; then
        if [[ -v cmd_VARIABLES[${i:1}] ]]; then
            cmd_PARAMETERS+=(${cmd_VARIABLES[${i:1}]})
        else
            echo "${i:1}: variable not recognized!"
            return 0
        fi
    else
        cmd_PARAMETERS+=($i)
    fi
done

#command parsing
case ${cmd_PARAMETERS[0]} in
    add)
        result=0
        for i in ${cmd_PARAMETERS[@]:1}; do
            let result+=$i
        done
        echo $result
        ;;
    subtract)
        result=${cmd_PARAMETERS[1]}
        for i in ${cmd_PARAMETERS[@]:2}; do
            let result-=$i
        done
        echo $result
        ;;
    multiply)
        result=1
        for i in ${cmd_PARAMETERS[@]:1}; do
            let result*=$i
        done
        echo $result
        ;;
    divide)
        result=${cmd_PARAMETERS[1]}
        for i in ${cmd_PARAMETERS[@]:2}; do
            let result/=$i
        done
        echo $result
        ;;
    cd)
        cd ${cmd_PARAMETERS[@]:1}
        ;;
    echo)
        echo ${cmd_PARAMETERS[@]:1}
        ;;
    for)
        for (( i=0; i<${cmd_PARAMETERS[1]}; i++ )); do
            cmd_eval ${cmd_PARAMETERS[@]:2}
        done
        ;;
    help)
        echo "help is in development"
        ;;
    ls)
        ls ${cmd_PARAMETERS[@]:1}
        ;;
    lsvars)
        echo ${!cmd_VARIABLES[@]}
        ;;
    var)
        cmd_VARIABLES[${cmd_PARAMETERS[1]}]=${cmd_PARAMETERS[2]}
        ;;
    exit)
        return 1
        ;;
    *)
        echo "Command ${cmd_PARAMETERS[0]} not recognized!"
        ;;
esac
}


while true; do



echo -n "${PWD##*/} > "
read cmd_INPUTSTRING
cmd_COMMAND=( $cmd_INPUTSTRING )
cmd_eval ${cmd_COMMAND[@]} || break

unset cmd_PARAMETERS


done

unset cmd_VARIABLES
unset cmd_PARAMETERS
unset cmd_INPUTSTRING
unset cmd_COMMAND
