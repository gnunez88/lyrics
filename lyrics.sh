#!/bin/bash
SINGERS_NAMES="${1:?Missing singers}"
SONG_NAME="${2:?Missing song}"

# Checking dependencies
CURL="$(which curl 2>/dev/null)" || echo "Missing dependency: curl" && exit 2
JQ="$(which jq 2>/dev/null)" || echo "Missing dependency: jq" && exit 2

URL_API="https://api.lyrics.ovh/v1"
SINGERS=${SINGERS_NAMES}
SONG=${SONG_NAME}

# URLencoding SINGERS
SINGERS="${SINGERS//\ /%20}"
SINGERS="${SINGERS//\&/%26}"
SINGERS="${SINGERS//\(/%28}"
SINGERS="${SINGERS//\)/%29}"
SINGERS="${SINGERS//\+/%2b}"
SINGERS="${SINGERS//\,/%2c}"
SINGERS="${SINGERS//\./%2e}"
SINGERS="${SINGERS//\//%2f}"
SINGERS="${SINGERS//\?/%3f}"

# URLencoding SONG
SONG="${SONG//\ /%20}"
SONG="${SONG//\&/%26}"
SONG="${SONG//\(/%28}"
SONG="${SONG//\)/%29}"
SONG="${SONG//\+/%2b}"
SONG="${SONG//\,/%2c}"
SONG="${SONG//\./%2e}"
SONG="${SONG//\//%2f}"
SONG="${SONG//\?/%3f}"

URL="${URL_API}/${SINGERS}/${SONG}"
JSON="$(curl -sS ${URL})"
LYRICS="$(echo "${JSON}" \
    | sed -e 's/\\r\\n/\\n/g' -e 's/\\n\\n/\\n/g' \
    | jq -r '.lyrics')"

STATUS_CODE=$?  # 0: success, 4: could not parse the JSON

if [ -z "${LYRICS}" ]; then
    echo -e "No lyrics retrieved for ${SINGERS_NAMES} - ${SONG_NAME}" >&2
    exit 1
else
    mkdir -p "${SINGERS_NAMES}"
    echo "${LYRICS}" > "${SINGERS_NAMES}/${SONG_NAME}.lrc"
fi
