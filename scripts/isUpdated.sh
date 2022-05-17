#!/bin/bash

ext_tag=$(curl -s \
            -H "Accept: application/vnd.github.v3+json" \
            https://api.github.com/repos/cloudflare/cloudflared/releases?page=1 | jq -r '.[0]["tag_name"]')

echo "**** External release is $ext_tag"

last_tag=$(curl -s \
            -H "Accept: application/json" \
            https://hub.docker.com/v2/repositories/afonsoc12/cloudflared/tags | jq -r '.["results"][1]["name"]')

echo "**** Last release is $ext_tag"

if [ -z "${ext_tag}" ] || [ "${ext_tag}" == "null" ]; then
    echo "**** Can't retrieve external release, exiting... ****"
    exit 1
elif [ -z "${last_tag}" ]; then
    echo "**** Can't retrieve last release, exiting... ****"
    exit 1
elif [ "$ext_tag" == "$last_tag" ]; then
    echo "**** Current release is still up-to-date ****"
    echo "    - Cloudflared version:  $ext_tag"
    echo "    - Last release version: $last_tag"
else
    version_file="DOCKER_VERSION.txt"
    echo "**** Triggering new release by creating the file: $version_file ****"
    echo "    Old version: $last_tag"
    echo "    NEW version: $ext_tag"
    echo $ext_tag > $version_file
fi 
            
