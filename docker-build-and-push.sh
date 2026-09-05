#!/usr/bin/env bash
# SCRIPT: docker-build-and-push.sh 
# PURPOSE: Builds a Docker image and pushes it to Docker Hub using input arguments.
# USAGE: ./docker-build-and-push.sh <username> <image_name> [version_tag] [password]
# ARGUMENTS: 
#   $1: Docker Hub username (required)
#   $2: Image name (required)
#   $3: Version tag (optional, defaults to current date YYYY-MM-DD)
#   $4: Docker Hub password or access token (optional, triggers non-interactive login if provided)

set -euo pipefail # Exit immediately on error, unset variables, or failed pipes

# Input arguments
user="${1:?'Error: Please provide your Docker Hub username as argument 1.'}"
imagename="${2:?'Error: Please provide the image name as argument 2.'}"
today=$(date '+%F')
number="${3:-"$today"}"
password="${4:-}"

# Construct image tags
tag="${user}/${imagename}"
version="${tag}:${number}"
latest="${tag}:latest"

echo "==> Building image: ${version} ..."
docker build --no-cache -t "${version}" -t "${latest}" .

echo "==> Logging in to Docker Hub ..."
if [ -n "${password}" ]; then
  # Non-interactive login using argument 4
  echo "${password}" | docker login -u "${user}" --password-stdin
else
  # Interactive login fallback
  docker login -u "${user}"
fi

echo "==> Pushing images to Docker Hub ..."
docker push "${version}"
docker push "${latest}"

echo "==> Successfully pushed ${version} and ${latest}"
