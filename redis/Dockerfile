FROM redis:7.2.3-alpine3.19

ENV APP_DIR="/app"

ARG USER_NAME=redis
ARG USER_ID=1000
ARG GROUP_NAME=redis
ARG GROUP_ID=1000

ENV PATH="${PATH}"

RUN apk add --no-cache bash curl

SHELL [ "/bin/bash", "-c" ]

RUN deluser redis && \
    addgroup -g "${GROUP_ID}" "${GROUP_NAME}" && \
    adduser -s /bin/bash -h "${APP_DIR}" -G "${GROUP_NAME}" -u "${USER_ID}" -D "${USER_NAME}"

RUN mkdir -p /usr/local/etc

WORKDIR "${APP_DIR}"

USER "${USER_NAME}"

COPY ./config/redis.conf /usr/local/etc/redis.conf
COPY --chown="${USER_ID}":"${GROUP_ID}" ./docker-entrypoint.sh "${APP_DIR}"/

ENTRYPOINT ["/bin/bash", "./docker-entrypoint.sh"]
