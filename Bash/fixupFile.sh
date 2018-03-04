#!/usr/bin/env bash

set -e

FILE=${1:?File parameter is required}

# Make sure the file is actually in git
git ls-files --error-unmatch "$FILE" >/dev/null
# If index is empty, stage changes in the file
git diff-index --quiet --cached HEAD && git add -p "$FILE"

# Fix up the last commit touching the file
LASTCOMMIT=$(git log -1 --format=%h "$FILE")
git commit --fixup "$LASTCOMMIT" --no-verify
git rebase -i HEAD~"$(git rev-list --count master..)" --autostash --autosquash
