#!/bin/bash

# Input without case sensitivity
su -c 'echo "set completion-ignore-case on" > /etc/inputrc'

# Automatic timezone
# ntpdate time-a.nist.gov
# rc-update add ntpd default
# rc-update add ntp-client default
## "if sabayon: then"

# EOF
