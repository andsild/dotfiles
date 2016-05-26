#!/bin/bash

if [ -z "${1}" ]
then
    printf "%s <filename to sort>\n" "$0"
    exit 1
fi

infile=${1}

function getSortedLineNumbers()
{
    grep -nE '^(\\begin{definition}|\\end{definition})' ${infile}  \
        | awk -F ":" '
        BEGIN { startline=0 ; string = "" }
        { 
        if (/.*\\begin/) { 
                string = $0;
                gsub(/(.*\[|\].*)/, "", string);
                startline = $1
            } 
        else 
        {
            printf "%s\t%s,%s\n", string, startline, $1 ; 
        }
    }' | sort | cut -d$'\t' -f2
}

outfile="/tmp/sortedTexOutput.tex"
test -e ${outfile} && rm ${outfile}
lineNumbers=$(getSortedLineNumbers)
for x in $lineNumbers
do
    startNum=${x%%,*}
    endNum=${x##*,}
    sed -n $startNum,${endNum}p ${infile} >> ${outfile}
    echo >> ${outfile}
done

sed '/\\begin{definition}/,/\\end{definition}/d' ${infile} >> ${outfile}

cat ${outfile}
