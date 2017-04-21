FROM ubuntu:xenial

ENV PROJECT_NAME="biosecurity_management" \
    DATABASE_URL="sqlite://:memory:" \
    SECRET_KEY="hackme"

# These dependencies are baggage we found we need often enough to include
# them in our base image
RUN apt-get update && \
    apt-get install -y python3 \
                       python3-pip \
                       python3-venv \
                       wget \
                       python-dev \
                       libpq-dev \
                       build-essential \
                       libxml2-dev \
                       libxslt1-dev \
                       libjpeg-dev \
                       graphviz \
                       graphviz-dev \
                       pkg-config \
                       postgresql-client \
                       git \
                       libgraphviz-dev \
                       libcgraph6 \
                       nginx && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /usr/share/man /tmp/* /var/tmp/* \
       /var/cache/apk/* /var/log/* /var/lib/apt/lists/* ~/.cache

# Include nginx logs in container logs
RUN mkdir -p /var/log/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

ADD ./ /app
ADD ./deploy/docker/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app/biosecurity_management

# Install virtualenv
RUN python3 -m venv ../.venv
RUN ../.venv/bin/pip install --upgrade pip && \
    ../.venv/bin/pip install -r ./requirements.txt > /tmp/pip-requirements.log

# Collect up static files
RUN ../.venv/bin/python3 manage.py collectstatic -i babel* \
                                              -i webpac* \
                                              -i uglify* \
                                              -i sha* \
                                              -i src \
                                              -i crypto-browserify \
                                              -i core-js \
                                              -i docs \
                                              -i media \
                                              --noinput > /tmp/collectstatic.log

RUN chmod +x /app/deploy/docker/scripts/entrypoint.sh

ENTRYPOINT ["/app/deploy/docker/scripts/entrypoint.sh"]
