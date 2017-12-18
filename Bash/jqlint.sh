#!/usr/bin/env bash

test -n "${1}" || (echo error! && exit 1)
jq '.' "${1}" 2>&1 | awk -v pattern=$1 '{ print pattern":"$0 }'
