clear
echo -e "\e[1;34m$(whoami)\e[0;34m@$(hostname)\e[0m"
echo
echo -e "\e[32mOS\e[0m:        $(( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1 | sed 's/^.//;s/.$//')"
echo -e "\e[32mDE\e[0m:        $XDG_CURRENT_DESKTOP"
echo -e "\e[32mShell\e[0m:     $(basename $SHELL)"
echo -e "\e[32mTerminal\e[0m:  $TERM"
echo -e "\e[32mEditor\e[0m:    $EDITOR"
echo -e "\e[31mSpace\e[0m:     $(df -l --total -h | awk -F' ' '/total/{print $3}')B / $(df -l --total -h | awk -F' ' '/total/{print $2}')B ($(df -l --total -h | awk -F' ' '/total/{print $5}'))"
echo -e "\e[31mCPU\e[0m:       $(cat /proc/cpuinfo | grep 'core id' | wc -l) cores @ $(lscpu | awk -F':' '/CPU max/{print $2/1000}')GHz"
echo -e "\e[31mRAM\e[0m:       $(free -g --si | grep -oP '\d+' | head -n 1)GB"
[ -f /bin/xdpyinfo ] && echo -e "\e[31mScreen\e[0m:    $(xdpyinfo | awk -F' ' '/dimensions/{print $2}')"
echo
