#!/bin/bash

if [[ "${DEV_MODE}" == "prod" ]] ; then
  uvicorn main:app \
    --app-dir "${APP_DIR}/src" \
    --host 0.0.0.0 \
    --port "${UVICORN_PORT}" \
    --workers "${UVICORN_WORKERS}" \
    --log-level "${UVICORN_LOG_LEVEL}" \
    --no-use-colors \
    --log-config=src/configs/logger.yaml
else
  uvicorn main:app \
    --app-dir "${APP_DIR}/src" \
    --reload-dir "${APP_DIR}/src" \
    --host 0.0.0.0 \
    --port "${UVICORN_PORT}" \
    --workers "${UVICORN_WORKERS}" \
    --log-level "${UVICORN_LOG_LEVEL}" \
    --no-use-colors \
    --log-config=src/configs/logger.yaml \
    --reload
fi
