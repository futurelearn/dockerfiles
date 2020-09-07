#!/bin/bash
#
set -eo pipefail

### Startup checks

for pkg in aws pigz mysqldump; do
  if ! which $pkg >/dev/null 2>&1; then
    echo "Requires package: ${pkg}", "ERROR"
    exit 1
  fi
done

### Options configurable by environment variable

## Required
[[ -z $DATADOG_API_KEY ]] && (echo "DATADOG_API_KEY required variable"; exit 1)
[[ -z $ENVIRONMENT ]]     && (echo "ENVIRONMENT required variable"; exit 1)
[[ -z $MYSQL_DATABASE ]]  && (echo "MYSQL_DATABASE required variable"; exit 1)
[[ -z $MYSQL_SSL_PATH ]]  && (echo "MYSQL_SSL_PATH required variable"; exit 1)
[[ -z $MYSQL_USERNAME ]]  && (echo "MYSQL_USERNAME required variable"; exit 1)
[[ -z $RDS_HOSTNAME ]]    && (echo "RDS_HOSTNAME required variable"; exit 1)
[[ -z $S3_BUCKET_NAME ]]  && (echo "S3_BUCKET_NAME required variable"; exit 1)
[[ -z $S3_KEY_PREFIX ]]   && (echo "S3_KEY_PREFIX required variable"; exit 1)

## Optional
[[ -z $AWS_REGION ]] && AWS_REGION="eu-west-1"
[[ -z $DEBUG ]] && DEBUG="false"
[[ -z $MYSQL_PORT ]] && MYSQL_PORT="3306"

### Script
set -u

if [[ "$DEBUG" == "true" ]]; then
  cat << EOF
AWS_REGION:     ${AWS_REGION}
MYSQL_DATABASE: ${MYSQL_DATABASE}
MYSQL_PORT:     ${MYSQL_PORT}
MYSQL_SSL_PATH: ${MYSQL_SSL_PATH}
MYSQL_USERNAME: ${MYSQL_USERNAME}
RDS_HOSTNAME:   ${RDS_HOSTNAME}
S3_BUCKET_NAME: ${S3_BUCKET_NAME}
S3_KEY_PREFIX:  ${S3_KEY_PREFIX}
EOF
fi

# Post an event to Datadog to start
curl -sSX POST -H "Content-type: application/json" \
-d "{
      \"title\": \"rds-to-s3-mysqldump\",
      \"text\": \"Started\",
      \"priority\": \"normal\",
      \"tags\": [\"environment:${ENVIRONMENT}\", \"task:mysqldump\"],
      \"alert_type\": \"info\"
}" "https://api.datadoghq.com/api/v1/events?api_key=${DATADOG_API_KEY}"


TOKEN=$(aws rds generate-db-auth-token --hostname "${RDS_HOSTNAME}" --port "${MYSQL_PORT}" --region "${AWS_REGION}" --username "${MYSQL_USERNAME}")
AWS_CP_OPTS="--only-show-errors"
KEY_TIMESTAMP=$(date +%F)

mysqldump \
  --host="${RDS_HOSTNAME}" \
  --port="${MYSQL_PORT}" \
  --ssl-ca="${MYSQL_SSL_PATH}" \
  --user="${MYSQL_USERNAME}" \
  --password="${TOKEN}" \
  --single-transaction \
  --enable-cleartext-plugin \
  "${MYSQL_DATABASE}" | pigz | aws --region ${AWS_REGION} s3 cp "${AWS_CP_OPTS}" - "s3://${S3_BUCKET_NAME}/${S3_KEY_PREFIX}_${KEY_TIMESTAMP}.gz"

# Post an event to Datadog to finish
curl -sSX POST -H "Content-type: application/json" \
-d "{
      \"title\": \"rds-to-s3-mysqldump\",
      \"text\": \"Finished\",
      \"priority\": \"normal\",
      \"tags\": [\"environment:${ENVIRONMENT}\", \"task:mysqldump\"],
      \"alert_type\": \"info\"
}" "https://api.datadoghq.com/api/v1/events?api_key=${DATADOG_API_KEY}"
