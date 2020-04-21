# Please ensure that this Dockerfile is in sync with ../Dockerfile.heroku-18-libssl1.0
FROM heroku/heroku:18-build.v16

ENV WORKSPACE_DIR="/app/builds" \
    S3_BUCKET="heroku-buildpack-python" \
    S3_PREFIX="heroku-18/" \
    STACK="heroku-18"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        libsqlite3-dev \
        python3-pip \
        python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN pip3 install --disable-pip-version-check --no-cache-dir -r /app/requirements.txt

COPY . /app
