#!/bin/bash

songStatus() {
    spotify="$(pidof spotify 1>/dev/null; \
        if [ "$?" -gt 0 ]
        then 
            printf " [[ No song playing ]]";
        else
            dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' \
        | awk '
    BEGIN { songName=""; artist="" }
    {
        if(NR==22) { for(i=2; i<NF+1; i++) { artist  =artist" "$i; } }
        if(NR==39) { for(i=3; i<NF+1; i++) { songName=songName" "$i } }
    }
    END { gsub(/"/,"", artist); gsub(/"/,"",songName);
          print artist":"songName }
    ' ; fi)"

    echo -n ${spotify}
}

(tail -f <<<$(printf "%s\n%s" "AAAAAA" "BBBB")) | dzen2 -l 2 -x 1000 -y 1000 -w 500

# EOF
