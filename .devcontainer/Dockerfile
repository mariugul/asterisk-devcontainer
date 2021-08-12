# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.187.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    software-properties-common  \
    git                         \
    curl                        \
    wget                        \
    libnewt-dev                 \
    libssl-dev                  \
    libncurses5-dev             \
    subversion                  \
    libsqlite3-dev              \
    build-essential             \
    libjansson-dev              \
    libxml2-dev                 \
    uuid-dev                    \
    doxygen                     \
    postgresql                  \
    postgresql-client           \
    unixodbc                    \
    unixodbc-dev                \ 
    odbc-postgresql             \
    alembic                     \
    python3                     \
    python3-pip                 \
    # UFW doesn't work in WSL
    ufw                         \ 
    debconf-utils