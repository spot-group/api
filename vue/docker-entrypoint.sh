#!/bin/bash

if [[ "${DEV_MODE}" == "prod" ]] ; then
  serve --single dist/ --listen "${VUE_PORT}"
else
  yarn --cwd "${APP_DIR}"/src --port "${VUE_PORT}" serve
fi
