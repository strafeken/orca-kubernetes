#!/bin/bash
export PATH=$PATH:/var/lib/rancher/rke2/bin
# Usage: ./deploy.sh <hostname> <image-tag>
HOSTNAME=$1
IMAGE_TAG=$2
if [ -z "$HOSTNAME" ] || [ -z "$IMAGE_TAG" ]; then
  echo "Usage: $0 <hostname> <image-tag>"
  exit 1
fi

rm -rf rendered
mkdir rendered
for f in *.yaml; do
  sed -e "s/ORCA_HOSTNAME/$HOSTNAME/g" -e "s/ORCA_IMAGE_TAG/$IMAGE_TAG/g" "$f" > "rendered/$f"
done

kubectl apply -f rendered/