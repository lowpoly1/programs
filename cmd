#!/bin/bash

declare -A cmd_VARIABLES
declare -a cmd_PARAMETERS
declare cmd_INPUTSTRING
declare cmd_COMMAND

cmd_varexp () {

echo "beginning variable expansion"

unset cmd_PARAMETERS

#variable expansion
for i; do
    echo "expanding ${i}"
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

}

cmd_eval () {

unset cmd_PARAMETERS

echo "beginning evaluation"

for i; do
    echo "working on ${i}"
    cmd_PARAMETERS+=($i)
done

echo "parameters:"

for i in ${cmd_PARAMETERS[@]}; do
    echo "${i}"
done


#command parsing

echo "beginning parsing"

case ${cmd_PARAMETERS[0]} in
    add)
        cmd_varexp ${cmd_PARAMETERS[@]}
        result=0
        for i in ${cmd_PARAMETERS[@]:1}; do
            let result+=$i
        done
        echo $result
        ;;
    subtract)
        cmd_varexp ${cmd_PARAMETERS[@]}
        result=${cmd_PARAMETERS[1]}
        for i in ${cmd_PARAMETERS[@]:2}; do
            let result-=$i
        done
        echo $result
        ;;
    multiply)
        cmd_varexp ${cmd_PARAMETERS[@]}
        result=1
        for i in ${cmd_PARAMETERS[@]:1}; do
            let result*=$i
        done
        echo $result
        ;;
    divide)
        cmd_varexp ${cmd_PARAMETERS[@]}
        result=${cmd_PARAMETERS[1]}
        for i in ${cmd_PARAMETERS[@]:2}; do
            let result/=$i
        done
        echo $result
        ;;
    cd)
        cmd_varexp ${cmd_PARAMETERS[@]}
        cd ${cmd_PARAMETERS[@]:1}
        ;;
    echo)
        cmd_varexp ${cmd_PARAMETERS[@]}
        echo ${cmd_PARAMETERS[@]:1}
        ;;
    for)
        #create variable
        # cmd_VARIABLES[${cmd_PARAMETERS[1]}]=0
        #create variable reference to increment within loop
        # declare -n cmd_INCREMENTVARIABLE=cmd_VARIABLES[${cmd_PARAMETERS[1]}]
        for (( incr=0; incr<${cmd_PARAMETERS[2]}; incr++ )); do
            echo "value of incr is: ${incr}"
            # echo "increment ${cmd_INCREMENTVARIABLE}"
            cmd_eval ${cmd_PARAMETERS[@]:3}
            #increment variable
            # let "cmd_INCREMENTVARIABLE++"
            # echo "about to start increment ${cmd_INCREMENTVARIABLE}"
            echo "value of incr is: ${incr}"
        done
        unset cmd_INCREMENTVARIABLE
        ;;
    help)
        echo "help is in development"
        ;;
    ls)
        cmd_varexp ${cmd_PARAMETERS[@]}
        ls ${cmd_PARAMETERS[@]:1}
        ;;
    lsvars)
        echo ${!cmd_VARIABLES[@]}
        ;;
    var)
        cmd_varexp ${cmd_PARAMETERS[@]}
        cmd_VARIABLES[${cmd_PARAMETERS[1]}]=${cmd_PARAMETERS[2]}
        ;;
    exit)
        echo "Exiting, goodbye!"
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
unset cmd_INPUTSTRING
unset cmd_COMMAND
