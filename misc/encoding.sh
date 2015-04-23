#!/bin/bash

cd ~/samba/Source/

x=$(for file in $(find . -iname "*.cs" -or -name "*.js" -type f)
do 
    ft=$(file --mime-encoding "$file" | awk '{print $2}')
    echo $ft
    # if [ $ft == "us-ascii" ]
    # then
    #     echo $file
    #     recode utf8 ${file}
    #     # iconv -f $ft -t UTF-8 $file > ./test.txt
    # fi
done)

sed 's/ /\r\n/g' <<<$(echo $x) | sort | uniq
