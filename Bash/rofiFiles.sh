#!/usr/bin/env bash

# clone and make install.
# you don't necesserily have to build rofi from scratch if you specify a plugin path
# https://github.com/marvinkreis/rofi-file-browser-extended

# for default binding of files, use mimeopen <file> to set default assocication
fdfind . "${HOME}" | rofi -modi file-browser-extended -show file-browser-extended -file-browser-stdin -file-browser-dir "${HOME}"
