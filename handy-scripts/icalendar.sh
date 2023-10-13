#!/usr/bin/env bash

DIR="$(dirname -- "$(readlink -f -- "$0";)";)"
TMP=$(awk -f "${DIR}/icalendar.awk" "$1")
DT0=$(awk '{print $1}' <<< "$TMP")
DATE="${DT0:0:4}-${DT0:4:2}-${DT0:6:2} ${DT0:9:2}:${DT0:11:2}:${DT0:13:2}"
TEXT=${TMP#* }

echo "${DATE}: ${TEXT}"
