FROM python:3.10-alpine3.18

ENV APP_DIR="/app"

ARG USER_NAME=fastapi
ARG USER_ID=1000
ARG GROUP_NAME=fastapi
ARG GROUP_ID=1000

ENV PATH="${APP_DIR}/.local/bin:${PATH}"

ARG DEV_MODE=develop
ENV DEV_MODE="${DEV_MODE}"
ARG UVICORN_PORT=3000
ENV UVICORN_PORT="${UVICORN_PORT}"
ARG UVICORN_WORKERS=5
ENV UVICORN_WORKERS="${UVICORN_WORKERS}"
ARG UVICORN_LOG_LEVEL=info
ENV UVICORN_LOG_LEVEL="${UVICORN_LOG_LEVEL}"

RUN apk add --no-cache bash curl

SHELL [ "/bin/bash", "-c" ]

RUN addgroup -g "${GROUP_ID}" "${GROUP_NAME}" && \
    adduser -s /bin/bash -h "${APP_DIR}" -G "${GROUP_NAME}" -u "${USER_ID}" -D "${USER_NAME}"

RUN pip3 install --upgrade pip virtualenv

USER "${USER_NAME}"
WORKDIR "${APP_DIR}"

RUN mkdir -p src && \
    python3 -m venv .venv

#RUN pip3 install fastapi && \
#    pip3 freeze > requirements.txt && \
#    cat requirements.txt

COPY --chown="${USER_ID}":"${GROUP_ID}" ./src "${APP_DIR}"/src/
COPY --chown="${USER_ID}":"${GROUP_ID}" ./requirements.txt "${APP_DIR}"/
COPY --chown="${USER_ID}":"${GROUP_ID}" ./docker-entrypoint.sh "${APP_DIR}"/

RUN pip install -r ./requirements.txt

ENTRYPOINT ["/bin/bash", "./docker-entrypoint.sh"]
