#!/bin/bash

BROWSER="google-chrome-stable"
# BROWSER="chrome"

xdg-mime default ${BROWSER}.desktop x-scheme-handler/http
xdg-mime default ${BROWSER}.desktop x-scheme-handler/https
xdg-mime default ${BROWSER}.desktop text/html
xdg-settings set default-web-browser ${BROWSER}.desktop
