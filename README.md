## Startup

```bash
export BUILDKIT_PROGRESS=plain

docker-compose up --build --remove-orphans --force-recreate
```

## Modes

### Docker Compose Mode (`compose`)

- auto reload `vue` / `fastapi` source code on live
- fast development when working in e.g.: `PyCharm` / `WebStorem`

#### Vue Dependencies

In `vue/src` run:

```bash
yarn install
```

#### Docker Compose

Commented Out `volumes` with source code

```bash
  vue:
    (...)
    #volumes:
    #  - ${PWD}/vue/src:/app/src:rw
  fastapi:
    (...)
    #volumes:
    #  - ${PWD}/fastapi/src/:/app/src
```

#### Set Environment Variable

```bash
DEV_MODE=compose
```

### Development Mode (`develop`)

#### Set Environment Variable

For `vue` / `fastapi` change `DEV_MODE` to `develop`

```bash
DEV_MODE=develop
```

### Production Mode (`prod`)

v v

#### Set Environment Variable

For `vue` / `fastapi` change `DEV_MODE` to `prod`

```bash
DEV_MODE=prod
```

## Redis

```bash
CONFIG GET databases

INFO keyspace

SELECT 1

SET key01 value01

KEYS *

```
