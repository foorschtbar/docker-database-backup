FROM python:3.9-alpine

LABEL org.opencontainers.image.ref.name="jan-di/database-backup"

RUN set -eux; \
    apk --no-cache add \
        mariadb-client \
        postgresql-client \
        tzdata

RUN set -eux; \
    pip install pipenv

WORKDIR /app

COPY Pipfile .
COPY Pipfile.lock .
RUN set -eux; \
    pipenv install --system

RUN set -eux; \
    mkdir -p /dump

ENV PYTHONUNBUFFERED=1

COPY . .

ENTRYPOINT [ "python3", "/app/main.py" ]