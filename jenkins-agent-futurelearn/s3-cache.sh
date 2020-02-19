#!/bin/bash
set -xeo pipefail

if [ -z "$MOUNT" ]; then
  echo "Must specify directories to cache. Exiting!"
  exit 1
fi

if [ -z "$CACHE_BUCKET" ]; then
  echo "Must specify CACHE_BUCKET environment variable"
  exit 1
fi

AWS_OPTS="--quiet"

# Convert forward slashes to escaped forward slashes
SED_SAFE_GIT_BRANCH=$(echo "$GIT_BRANCH" | sed 's/\//\\\//g')

MAIN_JOB_NAME=$(echo "$JOB_NAME" | sed "s/\/${SED_SAFE_GIT_BRANCH}//g")
CACHE_PATH="${MAIN_JOB_NAME}/${GIT_BRANCH}"
FALLBACK_PATH="${MAIN_JOB_NAME}/master"

PATHS_TO_TAR=$(echo $MOUNT | sed 's/,/ /g')

echo "Starting at $(date)"

if [[ $1 == "rebuild" ]]; then

  PATHS=""
  echo "Compressing selected paths:"
  for i in $PATHS_TO_TAR; do
    if test -e "$i"; then
      PATHS+=" ${i}"
      echo "Adding ${i}"
    else
      echo "Cannot find ${i}. Skipping."
    fi
  done

  if [[ $PATHS == "" ]]; then
    echo "No paths found for cache. Moving on..."
    exit 0
  else
    tar cf - "$PATHS" | pigz > archive.tgz
  fi

  echo "Compression complete, uploading to S3"

  aws s3 cp $AWS_OPTS ./archive.tgz "s3://${CACHE_BUCKET}/${CACHE_PATH}/archive.tgz"

  echo "Upload completed!"

  echo "Finished! Exiting at $(date)" && exit 0
elif [[ $1 == "restore" ]]; then

  if aws s3 cp $AWS_OPTS "s3://${CACHE_BUCKET}/${CACHE_PATH}/archive.tgz" archive.tgz; then
    echo "Cache downloaded successfully."
  elif aws s3 cp $AWS_OPTS "s3://${CACHE_BUCKET}/${FALLBACK_PATH}/archive.tgz" archive.tgz; then
    echo "Cache downloaded successfully."
  else
    echo "Cannot find cache. Skipping!"
    exit 0
  fi

  echo "Uncompressing cache file."
  unpigz < archive.tgz | tar -xC .
  echo "Cache uncompressed."

  echo "Finished! Exiting at $(date)" && exit 0
else
  echo "Must provide either restore or rebuild as first argument. Exiting!"
  exit 1
fi
