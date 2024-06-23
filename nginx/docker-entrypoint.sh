#!/bin/bash

function template_file() {
  FILES=$(find "templates/${1}" -type f -mindepth 1 -maxdepth 1 | grep -E ".*.template$")
  ENVSUBST="${ENVSUBST//\\/}"

  for SOURCE_PATH in ${FILES} ; do echo
    TARGET_PATH="${2}/$(basename $(echo "${SOURCE_PATH}" | sed -E "s/.template$//g"))"
    envsubst "${ENVSUBST}" < "${SOURCE_PATH}" > "${TARGET_PATH}"
  done
}

template_file etc /etc/nginx
template_file etc/conf.d /etc/nginx/conf.d

nginx -g 'daemon off;'
