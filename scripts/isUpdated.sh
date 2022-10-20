#!/bin/bash

retrieve_latest_release () {
    repo=$1
    local version=$(curl -s \
                -H "Accept: application/json" \
                https://api.github.com/repos/$repo/releases | \
                    jq -r '.[] | select(.prerelease==false and .draft==false) | .tag_name' | \
                    grep -Po '(\d+\.)?(\d+\.)?(\*|\d+)$' | \
                    sort -n -r | \
                    head -n1)
    echo $version
}

ext_tag=$(retrieve_latest_release 'cloudflare/cloudflared')

echo "**** External release is $ext_tag"

last_tag=$(retrieve_latest_release 'afonsoc12/docker-cloudflared')

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
