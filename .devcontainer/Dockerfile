FROM ubuntu:24.04

# Build arguments - builds in non-interactive mode
ARG DEBIAN_FRONTEND=noninteractive

USER root
WORKDIR /root

RUN apt-get update

# Locales
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
RUN apt-get install -y --no-install-recommends \
        locales \
    && locale-gen en_US.UTF-8

# Timezone configuration
ENV TZ=Europe/Rome
RUN apt-get install -y --no-install-recommends \
        tzdata \
    && ln -snf "/usr/share/zoneinfo/${TZ}" /etc/localtime \
    && echo "${TZ}" > /etc/timezone

# Install Essentials
RUN apt-get install -y --no-install-recommends \
        bash-completion \
        ca-certificates \
        curl \
        git \
        gnupg \
        iproute2 \
        jq \
        less \
        lsb-release \
        nano \
        openssh-client \
        procps \
        sudo \
        unzip \
        wget \
        zsh \
        rsync \
    && rm -rf /var/lib/apt/lists/*


# User configuration
ARG USERNAME=user
ARG USER_UID=1001
ARG USER_GID=1001
RUN groupadd --gid "${USER_GID}" "${USERNAME}"
RUN useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/zsh "${USERNAME}"
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}"
RUN chmod 0440 "/etc/sudoers.d/${USERNAME}"


USER ${USERNAME}
WORKDIR /home/${USERNAME}/workspace
CMD ["/bin/zsh"]
