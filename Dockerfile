FROM openkbs/jdk-mvn-py3

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
RUN apt-get install -y dbus-x11 
RUN apt-get install -y xdg-utils --fix-missing

## ---- user: developer ----
ENV USER=developer
ENV USER_NAME=${USER}
ENV HOME=/home/${USER}

RUN export DISPLAY=${DISPLAY} && \
    useradd ${USER} && \
    export uid=${USER_ID} gid=${GROUP_ID} && \
    mkdir -p ${HOME} && \
    mkdir -p ${HOME}/workspace && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER}:x:${USER_ID}:${GROUP_ID}:${USER},,,:${HOME}:/bin/bash" >> /etc/passwd && \
    echo "${USER}:x:${USER_ID}:" >> /etc/group && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER} && \
    chown ${USER}:${USER} -R ${HOME} && \
    apt-get clean all && \
    ls /usr/local/ 
    
WORKDIR ${HOME}
USER ${USER}
CMD ["/usr/bin/firefox"]

