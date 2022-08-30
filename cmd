#!/bin/bash

cmd_USERNAME="user"
cmd_HOSTNAME="host"

echo -n "$(cmd_USERNAME)@$(cmd_HOSTNAME) -- $ "
read cmd_INPUTSTRING
#cmd_COMMAND=${
echo cmd_INPUTSTRING | head -n1 | awk '{print $1;}'
#}
