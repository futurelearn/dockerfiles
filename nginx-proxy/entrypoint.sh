#!/bin/bash
set -e

if [[ -z "${STATIC_PAGES_BUCKET}" ]]; then
  echo "ERROR: must provide STATIC_PAGES_BUCKET environment variable"
  exit 1
fi

if [[ -z "${API_SERVER_NAME}" ]]; then
  echo "ERROR: must provide API_SERVER_NAME environment variable"
  exit 1
fi

[[ -z "${PORT}" ]]         && export PORT="80"
[[ -z "${BACKEND_HOST}" ]] && export BACKEND_HOST="127.0.0.1"

if [[ "${MAINTENANCE_MODE}" == "true" ]]; then
  export TEMPLATE="/etc/nginx/maintenance.conf.template"
else
  export TEMPLATE="/etc/nginx/default.conf.template"
fi

for error in 400 404 413 422 500 502 503; do
  curl -fsSL --retry 3 "https://${STATIC_PAGES_BUCKET}.s3.amazonaws.com/errors/${error}.html" -o "/app/public/system/errors/${error}.html"
done

# shellcheck disable=SC2016
envsubst '${BACKEND_HOST} ${PORT} ${API_SERVER_NAME}' < "${TEMPLATE}" > /etc/nginx/conf.d/default.conf

REALIP_CONF_FILE="/etc/nginx/conf.d/http_realip.conf"

echo "set_real_ip_from 10.0.0.0/8;" > $REALIP_CONF_FILE

for i in $(curl -sSL https://www.cloudflare.com/ips-v4); do
  echo "set_real_ip_from $i;" >> $REALIP_CONF_FILE
done

for i in $(curl -sSL https://www.cloudflare.com/ips-v6); do
  echo "set_real_ip_from $i;" >> $REALIP_CONF_FILE
done

echo "real_ip_header X-Forwarded-For;" >> $REALIP_CONF_FILE
echo "real_ip_recursive on;" >> $REALIP_CONF_FILE

exec "$@"
