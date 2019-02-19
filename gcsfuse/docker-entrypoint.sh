#!/bin/sh

if [ -n "$1" ]; then GCS_BUCKET=$1; fi
if [ -n "$2" ]; then MOUNT_DIR=$2; fi

if [ -z "$MOUNT_DIR" ]; then echo "MOUNT_DIR not set"; exit 1; fi
if [ -z "$GCS_BUCKET" ]; then echo "GCS_BUCKET not set"; exit 1; fi

mkdir -p $MOUNT_DIR

gcsfuse --dir-mode 777 -o allow_other $GCS_BUCKET $MOUNT_DIR
