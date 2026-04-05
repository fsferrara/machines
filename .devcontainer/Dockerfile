FROM ubuntu:24.04

# Build arguments - builds in non-interactive mode
ARG DEBIAN_FRONTEND=noninteractive

# Container environment variables
ENV TZ=Etc/UTC
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Essentials
USER root
WORKDIR /root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash-completion \
        ca-certificates \
        curl \
        git \
        gnupg \
        iproute2 \
        jq \
        less \
        locales \
        lsb-release \
        nano \
        openssh-client \
        procps \
        sudo \
        unzip \
        wget \
        zsh \
        rsync \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# User configuration
ARG USERNAME=user
ARG USER_UID=1010
ARG USER_GID=1010
RUN groupadd --gid "${USER_GID}" "${USERNAME}"
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/zsh "${USERNAME}"
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"
RUN chmod 0440 "/etc/sudoers.d/${USERNAME}"


USER ${USERNAME}
WORKDIR /home/${USERNAME}/workspace
CMD ["/bin/zsh"]
