#!/usr/bin/env bash
exec docker run -e DATABASE_URL="sqlite://:memory:" \
-e SECRET_KEY="hackme" \
-e COMPONENT_NAME=WEB \
-e ALLOWED_HOSTS="['*']" \
-e PACKAGE_NAME=biosecurity_management rest_docker
