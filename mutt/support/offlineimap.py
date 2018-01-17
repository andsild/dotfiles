#!/usr/bin/env python2
import re
import subprocess
import sys
import os

FNULL = open(os.devnull, 'w')

# Fetching passwords
def keychain_pass_posteo():
    try:
        subprocess.check_call(["gpg2", "--card-status", "1>&0"], stdout=FNULL, stderr=FNULL, shell=False)
    except subprocess.CalledProcessError:
        return "foobar"
    return subprocess \
            .check_output("gpg2 -dq /home/andsild/.123456789key.gpg", shell=True).decode("utf-8").rstrip('\n')


def keychain_pass_cxense():
    try:
        subprocess.check_call(["gpg2", "--card-status", "1&>0"], stdout=FNULL, stderr=FNULL)
    except subprocess.CalledProcessError:
        return "foobar"
    return subprocess \
        .check_output("gpg2 -dq /home/andsild/.12345678key.gpg", shell=True).decode("utf-8").rstrip('\n')

mapping = {
    'drafts':  '[Gmail]/Drafts',
    'sent':    '[Gmail]/Sent Mail',
    'flagged': '[Gmail]/Starred',
    'archive': '[Gmail]/All Mail',
    'trash':   '[Gmail]/Trash',
}

local_to_remote_mappings = mapping
remote_to_local_mappings = dict((v, k) for (k, v) in mapping.items())

default_folders = ['INBOX'] + list(mapping.values())

def gmail_local_to_remote_nametrans(additional=None):
    additional = additional or {}

    def func(folder):
        return additional.get(folder) or \
                local_to_remote_mappings.get(folder) or \
                folder

    return func

def gmail_remote_to_local_nametrans(additional=None):
    additional = additional or {}
    additional = dict((v, k) for (k, v) in additional.items())

    def func(folder):
        return additional.get(folder) or \
                remote_to_local_mappings.get(folder) or \
                folder

    return func

def gmail_folder_filter(*additional):
    allowed = default_folders + list(additional)

    return lambda folder: folder in allowed

# Also used by msmtp to obtain the password
if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == "cxense":
        print(keychain_pass_cxense())
    else:
        print(keychain_pass_posteo())

