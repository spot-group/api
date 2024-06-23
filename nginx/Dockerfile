FROM nginx:1.25-alpine3.18-slim

ENV APP_DIR="/app"

ARG USER_NAME=nginx
ARG USER_ID=1000
ARG GROUP_NAME=nginx
ARG GROUP_ID=1000

ENV PATH="${PATH}"

ARG DEV_MODE=develop
ENV DEV_MODE="${DEV_MODE}"
ARG NGINX_PORT=8080
ENV NGINX_PORT="${NGINX_PORT}"
ARG FASTAPI_ENDPOINT=fastapi
ENV FASTAPI_ENDPOINT="${FASTAPI_ENDPOINT}"
ARG FASTAPI_PORT=3000
ENV FASTAPI_PORT="${FASTAPI_PORT}"
ARG VUE_ENDPOINT=vue
ENV VUE_ENDPOINT="${VUE_ENDPOINT}"
ARG VUE_PORT=8080
ENV VUE_PORT="${VUE_PORT}"

RUN apk add --no-cache bash envsubst curl

SHELL [ "/bin/bash", "-c" ]

RUN deluser --remove-home nginx && \
    addgroup -g "${GROUP_ID}" "${GROUP_NAME}" && \
    adduser -s /bin/bash -h "${APP_DIR}" -G "${GROUP_NAME}" -u "${USER_ID}" -D "${USER_NAME}"

RUN mkdir -p \
    /var/{run,log,cache}/nginx /etc/nginx \
    "${APP_DIR}"/templates/etc/conf.d && \
    chown -R "${USER_ID}":"${GROUP_NAME}" \
    /var/{run,log,cache}/nginx /etc/nginx \
    "${APP_DIR}"/templates/etc/conf.d

USER "${USER_NAME}"
WORKDIR "${APP_DIR}"

COPY --chown="${USER_ID}":"${GROUP_ID}" ./config/*.template "${APP_DIR}"/templates/etc
COPY --chown="${USER_ID}":"${GROUP_ID}" ./config/conf.d/*.template "${APP_DIR}"/templates/etc/conf.d/
COPY --chown="${USER_ID}":"${GROUP_ID}" ./docker-entrypoint.sh "${APP_DIR}"/

ENTRYPOINT ["/bin/bash", "./docker-entrypoint.sh"]
