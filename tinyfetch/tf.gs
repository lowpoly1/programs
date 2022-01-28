"#{ %x[ clear ] }"
"#{ %x[ echo -e \e\[1m\e\[34m$(whoami)\e\[0m\e\[34m@$(hostname)\e\[0m ] }"
"#{ %x[ echo ] }"
"#{ %x[ echo -e \e\[32mOS\e\[0m:        $(( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1 | sed 's/^.//;s/.$//')]}"
"#{ %x[ echo -e \e\[32mDE\e\[0m:        $XDG_CURRENT_DESKTOP ]}"
"#{ %x[ echo -e \e\[32mShell\e\[0m:     $(basename $SHELL) ] }"
"#{ %x[ echo -e \e\[32mTerminal\e\[0m:  $TERM ] }"
"#{ %x[ echo -e \e\[31mCPU\e\[0m:       $(cat /proc/cpuinfo | grep 'core id' | wc -l) cores @ $(lscpu | awk -F':' '/CPU max/{print $2/1000}') GHz ] }"
"#{ %x[ echo -e \e\[31mRAM\e\[0m:       $(free -g --si | grep -oP '\\d+' | head -n 1) GB ] }"
"#{ %x[ echo -e \e\[31mScreen\e\[0m:    $(xdpyinfo | awk -F' ' '/dimensions/{print $2}') ] }"
