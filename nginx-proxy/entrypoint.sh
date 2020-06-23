#!/bin/bash
set -e

if [[ -z "${STATIC_PAGES_HOST}" ]]; then
  echo "ERROR: Must set STATIC_PAGES_HOST environment variable"
  exit 1
fi

[[ -z "${PORT}" ]]         && export PORT="80"
[[ -z "${BACKEND_HOST}" ]] && export BACKEND_HOST="127.0.0.1"

# shellcheck disable=SC2016
envsubst '${BACKEND_HOST} ${STATIC_PAGES_HOST} ${PORT}' < /etc/nginx/default.conf.template > /etc/nginx/conf.d/default.conf

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
