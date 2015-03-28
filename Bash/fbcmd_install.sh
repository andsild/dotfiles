#!/bin/bash

# Get the script
doThis()
{
	local downloadFile="fbcmd_update.php"

	# TODO: ensure wget and php is availible

    which php 2> /dev/null || (printf "%s\n" "you will need php installed" && exit 1)

    cd "~/Downloads"
	wget --output-document "$downloadFile" "https://raw.github.com/dtompkins/fbcmd/master/fbcmd_update.php" \
		&& php "$downloadFile"			\
		&& sudo php "$downloadFile"		\
		&& sudo php "$downloadFile" install
}

doThis || printf "Something went wrong!\n"

# EOF
