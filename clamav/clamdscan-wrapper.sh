#!/bin/bash
set -e

FILE=$1

[[ -z "${FILE}" ]] && echo "Please provide a file" && exit 2

COUNT=0
while [[ "${COUNT}" -lt 10 ]]; do
  test -f "${FILE}" && break
  sleep 1
  COUNT=$((COUNT+1))
done

if [[ "${COUNT}" -eq 10 ]]; then echo "Cannot access file ${FILE}" && exit 2; fi

clamdscan-original --quiet --stdout "${FILE}"
