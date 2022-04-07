FROM registry:2

ARG PROJECT_ROOT_FOLDER=docker_local_registry

# set current working directory
WORKDIR /developer/projects/$PROJECT_ROOT_FOLDER
RUN echo "Current working directory: $(pwd)"

RUN apk update && apk add apache2-utils

RUN mkdir /auth
RUN htpasswd -bBc /auth/htpasswd registry_user registry_pass

COPY . .

RUN mv /etc/docker/registry/config.yml /etc/docker/registry/config_original.yml
RUN cp registry_config.yml /etc/docker/registry/config.yml
