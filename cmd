#!/bin/bash

declare -A cmd_VARIABLES
declare -a cmd_PARAMETERS
declare cmd_INPUTSTRING
declare cmd_COMMAND
declare cmd_ISARITHMETICEVAL
declare -a cmd_ARITHMETICPARAMETERS

cmd_aritheval () {
    declare -i layer=0
    declare -a locallist
    declare -a layerlist
    declare -a finallist
    declare whichlist=locallist

    #make local copy of list
    for item in ${1}; do
        locallist+=(${item})
    done
    
    #parantheses
    for item in ${!locallist}; do
        if [[ ${locallist[${item}]} == "(" ]]; then
            let layer++
            whichlist=layerlist
            [[ ${whichlist} == layerlist ]] && layerlist+=(${locallist[${item}]})
            continue
        fi
        if [[ ${locallist[${item}]} == ")" ]]; then
            if [[ ${layer} > 1 ]]; then
                let layer--
                ${!whichlist}+=(${locallist[${item}]})
            elif [[ ${layer} < 1 ]]; then
                echo "Bad syntax!"
                break
            else
                whichlist=locallist
                cmd_aritheval ${layerlist}
            fi
            continue
        fi
    done

    #multiply
    for item in ${!1}; do
        if
    done

}

cmd_varexp () {

    unset cmd_PARAMETERS

    #variable expansion
    for ((i=1; i<=$#; i++)); do

        #put params into array to be evaluated by arithmetic function
        if [[ ${cmd_ISARITHMETICEVAL} == true ]]; then
            cmd_ARITHMETICPARAMETERS+=(${!i})
        fi

        if [[ ${!i::1} == "\$" ]]; then

            if [[ ${!i:1:2} == "[[" ]]; then
                cmd_ISARITHMETICEVAL=true
                continue
            elif [[ ${!i:1:2} == "]]" ]]; then
                cmd_aritheval ${cmd_ARITHMETICPARAMETERS}
                cmd_ISARITHMETICEVAL=false
                continue
            fi

            if [[ -v cmd_VARIABLES[${!i:1}] ]]; then
                cmd_PARAMETERS+=(${cmd_VARIABLES[${!i:1}]})
            else
                echo "${!i:1}: variable not recognized!"
                return 0
            fi


        else
            cmd_PARAMETERS+=(${!i})
        fi

    done

}

cmd_eval () {

unset cmd_PARAMETERS

for i; do
    cmd_PARAMETERS+=($i)
done


#command parsing


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
        cmd_INCREMENTVARIABLE=${cmd_PARAMETERS[1]}
        cmd_VARIABLES[${cmd_INCREMENTVARIABLE}]=0
        local cmd_INCREMENTTARGET=${cmd_PARAMETERS[2]}
        declare -a cmd_LOOPARGS=(${cmd_PARAMETERS[@]:3})
        while [[ ${cmd_VARIABLES[${cmd_INCREMENTVARIABLE}]} -lt ${cmd_INCREMENTTARGET} ]]; do
            cmd_eval ${cmd_LOOPARGS[@]}
            #increment variable
            let cmd_VARIABLES[${cmd_INCREMENTVARIABLE}]++
        done
        unset cmd_INCREMENTTARGET
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
