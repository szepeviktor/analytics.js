#!/bin/bash
#
# Commit new version of analytics.js.
#
# DEPENDS       :npm install js-beautify

set -e

URL="https://www.google-analytics.com/analytics.js"

ANALYTICS="analytics.js"
BEAUTY="analytics.beauty.js"

cd "$(git rev-parse --show-toplevel)"

wget -nv -t 1 -O "$ANALYTICS" "$URL"

js-beautify --space-after-anon-function --good-stuff --wrap-line-length 120 \
    -o "$BEAUTY" "$ANALYTICS"

VERSION="$(sed -n -e 's/^\s*d\.push("_v=\([[:alnum:]]\+\)");$/\1/p' "$BEAUTY")"

test -n "$VERSION"

git add -A
git commit --date="$(date -R)" -m "Release ${VERSION}"
git tag "$VERSION"

echo "git push; git push --tags"
