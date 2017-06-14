#!/bin/bash
#
# Track changes of Google analytics.js.
#

A_URL="https://www.google-analytics.com/analytics.js"

A_MD5="$(md5sum "${HOME}/project/analytics.js/analytics.js")"

ONLINE_MD5="$(wget -T 10 -q -O- "$A_URL" | md5sum)"

if [ "${ONLINE_MD5%% *}" != "${A_MD5%% *}" ]; then
    echo "Google's analytics.js content changed: ${ONLINE_MD5}
        https://developers.google.com/analytics/devguides/collection/analyticsjs/changelog" \
        | mailx -s "Google analytics.js" root
fi

exit 0
