#!/bin/bash

INSTALLHOME="/home/minima/.minima/webroot/minidapps"
MINIDAPPSHOME="/home/minima/dapps"

BLOCK='0x706CC30B6C8EBFEEA814AA15E98FF13B162C1A83'
MEG='0x550863257C7BC4E43189EECE63ED8379525F4FC1'
TERMINAL='0x77815EAD479CCEAE16DEFC37A034004DF4BE2ED9'
WALLET='0x15AFF5A5E2671E7FA643A252A944C31E7D746DBB'

BLOCKHOME="${INSTALLHOME}/${BLOCK}"
MEGHOME="${INSTALLHOME}/${MEG}"
TERMINALHOME="${INSTALLHOME}/${TERMINAL}"
WALLETHOME="${INSTALLHOME}/${WALLET}"

BLOCKDAPP="block.minidapp"
MEGDAPP="emh.minidapp"
TERMINALDAPP="terminal.minidapp"
WALLETDAPP="wallet.minidapp"

INSTALLURL="127.0.0.1:9002/minidapps%20install"

echo "Installing DAPPS"

sleep 35s

while :
do
    if timeout 5 /bin/bash -c "cat < /dev/null >/dev/tcp/127.0.0.1/9004"; then
        break;
    else 
        sleep 5
    fi 
done

if [ ! -d "$BLOCKHOME" ]; then
    curl "${INSTALLURL}:${MINIDAPPSHOME}/${BLOCKDAPP}"
fi

if [ ! -d "$MEGHOME" ]; then 
    curl "${INSTALLURL}:${MINIDAPPSHOME}/${MEGDAPP}"
fi

if [ ! -d "$TERMINALHOME" ]; then 
    curl "${INSTALLURL}:${MINIDAPPSHOME}/${TERMINALDAPP}"
fi

if [ ! -d "$WALLETHOME" ]; then 
    curl "${INSTALLURL}:${MINIDAPPSHOME}/${WALLETDAPP}"
fi
