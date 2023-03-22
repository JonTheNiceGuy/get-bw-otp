#!/bin/sh
if [ -n "$1" ]
then
    if BW_SESSION="$(bw unlock --raw)"
    then
        export BW_SESSION
        if [ "$1" = "list" ]
        then
            bw list items | jq '.[] | select(.login.totp) | "\(.id),\"\(.name)\""' -r
            exit 32
        else
            MFA="$(bw get totp $1)"
            _return=$?
            echo "$MFA"
            exit $_return
        fi
    else
        exit $?
    fi
else
    echo "To get your OTP code, please run $0 <ITEM_ID>"
    exit 127
fi
