# Container image that runs your code
FROM jupyter/minimal-notebook:latest
USER root
RUN apt-get update && apt-get install -yq --no-install-recommends \
    texlive-lang-all \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
