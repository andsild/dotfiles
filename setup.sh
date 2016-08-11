#!/usr/bin/env bash

SOURCE="./Bash/Functions/*"
for file in ${SOURCE}
do
    test -f "${file}" && source "${file}"
done

declare -a INSTALL_ENTRY # normal array

INSTALL_ENTRY+=("${XDG_CONFIG_HOME:-$HOME/.config/nvim}/.                        : ./vim")
INSTALL_ENTRY+=("${HOME}/.                        : ./gdb/gdbinit")
INSTALL_ENTRY+=("${HOME}/.                        : ./Screen/screenrc")
INSTALL_ENTRY+=("${HOME}/.                        : ./Python/pylintrc")
INSTALL_ENTRY+=("${HOME}/.inputrc                 : ./dotfiles/BashRC/inputrc")
INSTALL_ENTRY+=("${HOME}/.gitconfig                 : ./dotfiles/git/gitconfig")

for file in ./BashRC/*
do
    test -f "${file}" || continue
    INSTALL_ENTRY+=("${HOME}/.    :   ${file}")
done

function installFile
{
    if (( $# != 2 )) && [ -n "${1}" ] && [ -n "${2}" ]
    then
        die 1 "bad arguments to installFile"
    fi

    local destFolder
    destFolder="$(readlink --canonicalize-missing "${1}")"
    local sourceFile
    sourceFile="$(readlink --canonicalize-missing "${2}")"
    local suffix=${sourceFile}
    # File should be hidden?
    if [ "${1: -1}" == "." ]
    then
        suffix=${sourceFile%/*}/.${sourceFile##*/}
    fi
    local destFile="${destFolder}/${suffix##*/}"

    if [ -d "${sourceFile}" ]
    then
        echo "${destFile}"
        #destFile=${destFolder}

    elif [ ! -d "${destFolder}" ] 
    then
        mkdir --parents --verbose "${destFolder}"
    fi


    if [ ! -L "${destFile}" ]
    then
        ln --symbolic --verbose "${sourceFile}" "${destFile}"
    else
        printf ""
        printf "skipping %s - already exists\n" "${destFile}" > /dev/fd/2
    fi
}

for entry in "${INSTALL_ENTRY[@]}"
do
    #split into two vars from the colon in the
    # center, and remove trailing/leading spaces
    dest="${entry%%[[:space:]]*:*}" # Syntax: for the lolz.. 
    src="${entry##*:*[[:space:]]}" # Syntax: for the lolz.. 
    installFile "${dest}" "${src}"
done
