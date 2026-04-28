#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
  exit 1
fi

# Assign arguments to variables
REPOSITORY_PATH="$1"
IMAGE_NAME="$2"
PROJECT_ID="$3"

echo "Listing untagged images for ${REPOSITORY_PATH}/${IMAGE_NAME}"
UNTAGGED_DIGESTS=$(gcloud artifacts docker images list "${REPOSITORY_PATH}/${IMAGE_NAME}" --include-tags --filter="-tags:*" --project="${PROJECT_ID}" --format="value(DIGEST)")

if [ -z "${UNTAGGED_DIGESTS}" ]; then
  echo "No untagged images found to delete."
else
  echo "Found untagged images with the following digests:"
  echo "Delete old artifacts first before pushing new images"
  echo "NOTE: the current artifacts will not be removed. once this build is pushed, it will tagged as latest and 2 revisions will show in artifact registry."
  echo "${UNTAGGED_DIGESTS}"
  echo "Deleting untagged images..."
  for DIGEST in ${UNTAGGED_DIGESTS}; do
    echo "Deleting ${REPOSITORY_PATH}/${IMAGE_NAME}@${DIGEST}"
    gcloud artifacts docker images delete "${REPOSITORY_PATH}/${IMAGE_NAME}@${DIGEST}" --quiet --delete-tags || true # Use || true to prevent build failure if a specific delete fails
  done
  echo "Untagged image deletion complete."
fi