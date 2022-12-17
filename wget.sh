#!/bin/bash

# Set system wide proxy configs for wget.
# Just for test: sed -E "s:/:\\\/:g"

sed -E "s/.*http_proxy.*$/http_proxy=http:\/\/${PROXY_DOMAIN}:${PROXY_PORT}\//"
