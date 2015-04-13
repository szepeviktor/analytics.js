#!/bin/bash
#
# Track changes of Google analytics.js.

A_MD5="EDIT"

A_URL="https://www.google-analytics.com/analytics.js"

CURRENT_MD5="$(wget -q -O- "$A_URL" | md5sum)"

if [ "$CURRENT_MD5" != "${A_MD5}  -" ]; then
    echo "Google's analytics.js content changed: ${CURRENT_MD5}
        https://developers.google.com/analytics/devguides/collection/analyticsjs/changelog" \
    | mailx -s "Google analytics.js" root
fi

exit 0
