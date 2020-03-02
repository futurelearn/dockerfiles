#!/bin/bash

set -e

[[ -n "$CLAM_DAEMON_ADDRESS" ]] || CLAM_DAEMON_ADDRESS=127.0.0.1
echo "TCPAddr ${CLAM_DAEMON_ADDRESS}" >> /etc/clamav/clamd.conf

exec "$@"
