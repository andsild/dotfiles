#!/usr/bin/env bash

# https://github.com/marvinkreis/rofi-file-browser-extended
fdfind . "${HOME}" | rofi -plugin-path /usr/local/lib/ -show file-browser-extended -file-browser-stdin -file-browser-dir "${HOME}"
