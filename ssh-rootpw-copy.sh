#!/bin/bash

SOURCE=localhost
TARGETS='sonne somehost anotherhost'

PASSWORD=`ssh $SOURCE 'getent shadow root | cut -f2 -d:'`
if [[ -n "$PASSWORD" ]];
then
    echo PASSWORD-HAST = $PASSWORD
    for TARGET in $TARGETS
    do
        echo -n "SET ROOT-PASSWORT FOR HOST: $TARGET "
        OS=`ssh $TARGET 'uname -s'`
        if [ $OS == "Linux" ]
        then
            ssh $TARGET  "usermod -p '$PASSWORD' root" 2> /dev/null && echo Done 
        else
            echo "Failed (wrong OS or unreachable )"
        fi
    done
fi
