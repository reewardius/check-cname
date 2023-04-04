#!/bin/bash

while read -r domain; do
    a=$(dig a "$domain" +nostats +nocomments +nocmd 2>&1)
    if [[ "$a" == *SERVFAIL* ]] || [[ "$a" == *REFUSED* ]]; then
        cname=$(dig CNAME "$domain" +short)
        if [[ -n "$cname" ]]; then
            echo "$domain - CNAME $cname"
        fi
    fi
done < "$1"
