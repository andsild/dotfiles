#!/bin/bash
# YouTube Video Player
# Required: uzbl, youtube-dl, mplayer

# Uncomment one of these modes.
#FORMATS=()   # Play SD quality.
FORMATS=(22 18 UZBL_URI) # Play best HD quality available.
#FORMATS=(UZBL_URI 18 22) # Play worst HD quality available.

# Settings
MPLAYER_COMMAND=(mplayer -really-quiet)
VALID_URL=0
exec &>/dev/null

# Plays the first format found.
if fgrep 'http://www.youtube.com/watch' -q <<< "$UZBL_URI"; then
  VALID_URL=1
  for f in "${FORMATS[@]}"; do
    URL=$(youtube-dl -f "$f" -g "$UZBL_URI")
    if [[ $URL ]] ; then
	    "${MPLAYER_COMMAND[@]}" "$URL"
      exit
    fi
  done
fi

if [[ $VALID_URL = 1 ]]; then
  "${MPLAYER_COMMAND[@]}" "$(youtube-dl -g "$UZBL_URI")"
fi

# EOF
