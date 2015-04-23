#!/bin/bash

file="${1}"

echo need perms...
sudo true

sudo sed 's/^\(>\)\{0,1\}\=//g ; s/-[0-9]\{1,2\}\.[0-9]\{1,2\}\.[0-9]\{1,2\}.* / /g' -i ${file}
