#!/bin/bash
set -e

sleep 3s
echo "Service started."
nginx -g 'daemon off;'
