#!/bin/bash

inData=""

if [ -n "${1}" ]
then
    inData=$(cat "${1}")
else
    IFS=$'\n' # read lines separated by newline
    while read -r input
    do
        inData="$(printf "%s\n%s" "${inData}" "${input}")"
    done
fi

function getSortedLineNumbers()
{
    printf "%s\n" "${1}" \
        | awk '
        BEGIN { startline=0 ; string = "" }
        { 
        if (/.*\\begin{definition}/) { 
                string = $0;
                gsub(/(.*\[|\].*)/, "", string);
                startline = NR
            } 
        if (/.*\\end{definition}/)
        {
            printf "%s\t%s,%s\n", string, startline, NR; 
        }
    }' | sort | cut -d$'\t' -f2
}

outfile="/tmp/sortedTexOutput.tex"
test -e ${outfile} && rm ${outfile}
lineNumbers=$(getSortedLineNumbers "${inData}")

for x in $lineNumbers
do
    startNum=${x%%,*}
    endNum=${x##*,}
    printf "%s\n" "${inData}" | sed -n "$startNum,${endNum}p" >> ${outfile}
    echo >> ${outfile}
done

printf "%s\n" "${inData}" | sed '/\\begin{definition}/,/\\end{definition}/d' >> "${outfile}"

cat ${outfile}
