FROM nginx:1.9.14

# this is the django project name
# TODO: make this consistent with entrypoint.sh variable naming...
ENV PROJECT_NAME biosecurity_management

# These dependencies are baggage we found we need often enough to include
# them in our base image
RUN apt-get update && \
    apt-get install -y python wget libpq-dev python-dev build-essential libxml2-dev libxslt1-dev libjpeg-dev graphviz graphviz-dev pkg-config postgresql-client git libgraphviz-dev libcgraph6 && \
    apt-get clean 

# bootstrap our python install
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install virtualenv

ADD ./ /app
ADD ./deploy/docker/nginx.conf /etc/nginx/nginx.conf

RUN echo "bumping docker, yech"
# Install virtualenv
RUN cd /app && \
    virtualenv .venv && \
    pip install --upgrade pip && \
    .venv/bin/pip install -r ./requirements.txt > /tmp/pip-requirements.log


# We assume that someone already ran `npm install`, which installs all
# JS requirements and compile webpack assets.

# Collect up static files
RUN cd /app && \
     . ./.venv/bin/activate && \
    cd $PROJECT_NAME && \
    python manage.py collectstatic -i babel* -i webpac* -i uglify* -i sha* -i src -i crypto-browserify -i core-js -i docs -i media --noinput > /tmp/collectstatic.log

# Include nginx logs in container logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN chmod +x /app/deploy/docker/scripts/entrypoint.sh

ENTRYPOINT ["/app/deploy/docker/scripts/entrypoint.sh"]
