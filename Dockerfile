FROM ubuntu:xenial

# this is the django project name
# TODO: make this consistent with entrypoint.sh variable naming...
ENV PROJECT_NAME biosecurity_management

# These dependencies are baggage we found we need often enough to include
# them in our base image
RUN apt-get update
RUN apt-get install -y python3 \
                       python3-pip \
                       python3-venv \
                       wget \
                       libpq-dev \
                       python-dev \
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
                       nginx
RUN apt-get clean

ADD ./ /app
ADD ./deploy/docker/nginx.conf /etc/nginx/nginx.conf

WORKDIR /app/biosecurity_management

# Install virtualenv
RUN python3 -m venv .venv
RUN .venv/bin/pip install -r ./requirements.txt > /tmp/pip-requirements.log

# Collect up static files
RUN DATABASE_URL="sqlite://:memory:" SECRET_KEY="hackme" .venv/bin/python3 manage.py collectstatic -i babel* \
                                                               -i webpac* \
                                                               -i uglify* \
                                                               -i sha* \
                                                               -i src \
                                                               -i crypto-browserify \
                                                               -i core-js \
                                                               -i docs \
                                                               -i media \
                                                               --noinput > /tmp/collectstatic.log

# Include nginx logs in container logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN chmod +x /app/deploy/docker/scripts/entrypoint.sh

ENTRYPOINT ["/app/deploy/docker/scripts/entrypoint.sh"]
