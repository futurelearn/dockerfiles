#!/bin/bash
set -e

if [[ -z "${STATIC_PAGES_HOST}" ]]; then
  echo "ERROR: Must set STATIC_PAGES_HOST environment variable"
  exit 1
fi

[[ -z "${PORT}" ]]         && export PORT="80"
[[ -z "${BACKEND_HOST}" ]] && export BACKEND_HOST="127.0.0.1"

if [[ "${MAINTENANCE_MODE}" == "true" ]]; then
  export TEMPLATE="/etc/nginx/maintenance.conf.template"
else
  if [[ -z "${API_SERVER_NAME}" ]]; then
    echo "ERROR: Must set API server name"
    exit 1
  fi

  export TEMPLATE="/etc/nginx/default.conf.template"
fi

# shellcheck disable=SC2016
envsubst '${BACKEND_HOST} ${STATIC_PAGES_HOST} ${PORT} ${API_SERVER_NAME}' < "${TEMPLATE}" > /etc/nginx/conf.d/default.conf

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
