#!/bin/sh
#
# adds Change-Id to commits which are not pushed yet (Fixes the commit bithday problem)
#
tmp=$(mktemp)
hook=$(readlink -f $(git rev-parse --git-dir))/hooks/commit-msg
git filter-branch -f --msg-filter "cat > $tmp; \"$hook\" $tmp; cat $tmp" @{u}..HEAD

