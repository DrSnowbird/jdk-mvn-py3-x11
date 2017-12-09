FROM openkbs/jre-mvn-py3

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

ARG DISPLAY=${DISPLAY:-":0.0"}
ENV DISPLAY=${DISPLAY}

ARG USER_ID=${USER_ID:-1000}
ENV USER_ID=${USER_ID}

ARG GROUP_ID=${GROUP_ID:-1000}
ENV GROUP_ID=${GROUP_ID}

## ---- X11 ----
RUN apt-get update && \
    apt-get install -y sudo xauth xorg openbox && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev firefox && \
    apt-get install -y apt-transport-https ca-certificates libcurl3-gnutls

RUN apt-get install -y apt-utils packagekit-gtk3-module libcanberra-gtk3-module

## ---- user: developer ----
ENV USER_NAME=developer
ENV HOME=/home/${USER_NAME}

RUN export DISPLAY=${DISPLAY} && \
    useradd ${USER_NAME} && \
    export uid=${USER_ID} gid=${GROUP_ID} && \
    mkdir -p ${HOME} && \
    mkdir -p ${HOME}/workspace && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER_NAME}:x:${USER_ID}:${GROUP_ID}:${USER_NAME},,,:${HOME}:/bin/bash" >> /etc/passwd && \
    echo "${USER_NAME}:x:${USER_ID}:" >> /etc/group && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME} && \
    chown ${USER_NAME}:${USER_NAME} -R ${HOME} && \
    apt-get clean all && \
    ls /usr/local/ 
    
WORKDIR ${HOME}

CMD "/usr/bin/firefox"
