FROM node:20.10-alpine3.18

ENV APP_DIR="/app"

ARG USER_NAME=vue
ARG USER_ID=1000
ARG GROUP_NAME=vue
ARG GROUP_ID=1000

ENV PATH="${APP_DIR}/.yarn/bin:${PATH}"

ARG DEV_MODE=develop
ENV DEV_MODE="${DEV_MODE}"

ARG VUE_PORT=8080
ENV VUE_PORT="${VUE_PORT}"

RUN apk add --no-cache bash curl

SHELL [ "/bin/bash", "-c" ]

RUN deluser node && \
    addgroup -g "${GROUP_ID}" "${GROUP_NAME}" && \
    adduser -s /bin/bash -h "${APP_DIR}" -G "${GROUP_NAME}" -u "${USER_ID}" -D "${USER_NAME}"

WORKDIR "${APP_DIR}"

USER "${USER_NAME}"

RUN mkdir -p "${APP_DIR}"/src/node_modules/.cache && \
    chown -R "${USER_ID}":"${GROUP_ID}" "${APP_DIR}"/src/node_modules && \
    chown -R "${USER_ID}":"${GROUP_ID}" "${APP_DIR}"/src/node_modules/.cache

RUN yarn global add @vue/cli @vue/cli-service serve

COPY --chown="${USER_ID}":"${GROUP_ID}" ./src "${APP_DIR}"/src/
COPY --chown="${USER_ID}":"${GROUP_ID}" ./docker-entrypoint.sh "${APP_DIR}"/

RUN if [[ "${DEV_MODE}" != "compose" ]]; then yarn install --cwd ./src ; fi
RUN if [ "${DEV_MODE}" = "prod" ]; then cd src && yarn build && mv dist ../ && cd ../ && rm -rf src/ ; fi

ENTRYPOINT ["/bin/bash", "./docker-entrypoint.sh"]
