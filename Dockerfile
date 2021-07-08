FROM openkbs/jdk-mvn-py3

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

ARG DISPLAY=${DISPLAY:-":0.0"}
ENV DISPLAY=${DISPLAY}

USER root

## ---- X11 ----
RUN apt-get update && \
    # apt-get install -y sudo xauth xorg openbox && \
    apt-get install -y sudo xauth xorg fluxbox && \
    apt-get install -y libxext-dev libxrender-dev libxtst-dev firefox && \
    apt-get install -y apt-transport-https ca-certificates libcurl3-gnutls

#RUN apt-get install -y apt-utils packagekit-gtk3-module libcanberra-gtk3-module
RUN apt-get install -y dbus-x11 
RUN apt-get install -y xdg-utils --fix-missing

## ---- user: developer ----
ENV USER=${USER:-developer}

ENV USER_NAME=${USER}
ENV HOME=/home/${USER}
ENV WORKDIR=/home/${USER}
ENV INST_SCRIPTS=${HOME}/scripts
    
COPY scripts $HOME/scripts
RUN sudo chown -R $USER:$USER ${INST_SCRIPTS} && chmod +x ${INST_SCRIPTS}/*.sh

########################
#### ---- Yarn ---- ####
########################
# Ref: https://classic.yarnpkg.com/en/docs/install/#debian-stable
# fix yarn key
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -y && \ 
    apt-get install -y yarn
    
#######################################
#### ---- Firefox libs:       ---- ####
#######################################
RUN sudo apt-get install -y xdg-utils libgbm1 --fix-missing

#### ============================================
#### ---- Google-Chrome install:  ----
#### ============================================
#RUN ${INST_SCRIPTS}/google-chrome.sh  
 
#######################################
#### ---- Google-Chrome       ---- ####
#######################################
ARG CHROME_DEB_URL=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
ARG CHROME_DEB=google-chrome-stable_current_amd64.deb
#wget -cq https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN wget -cq ${CHROME_DEB_URL} && \
    sudo apt-get update && \
    sudo apt-get --fix-broken install -y && \
    sudo apt-get install -y fonts-liberation libnspr4 libnss3 && \
    sudo dpkg -i ${CHROME_DEB} && \
    rm ${CHROME_DEB}

COPY ./config/Desktop ${HOME}/Desktop

#### ------------------------------------------------
#### ---- Desktop setup (Google-Chrome, Firefox) ----
#### ------------------------------------------------
ADD ./config/Desktop $HOME/

RUN sudo apt-get update -y && \
    sudo rm -f /var/run/firefox-restart-required && \
    #sudo mkdir -p /var/run/dbus/system_bus_socket && chmod -R 0777 /var/run/dbus/system_bus_socket && \
    sudo mkdir -p /host/run/dbus/system_bus_socket && sudo chmod -R 0777 /host/run/dbus/system_bus_socket && \
    sudo ln -s ${INST_SCRIPTS}/docker-entrypoint.sh /usr/local/docker-entrypoint.sh && \
    sudo rm -rf ${HOME}/.cache && \
    sudo chown -R ${USER}:${USER} ${HOME}
    # sudo mkdir -p /host/run/dbus/system_bus_socket
    # sudo apt-get install -qqy x11-apps

#=================================
# DBus setup
#=================================
##  ---- dbus setup ----
#ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
ENV unix:runtime=yes

#=================================
# Fix sudo issue: 
# sudo: setrlimit(RLIMIT_CORE): Operation not permitted
#=================================
RUN echo "Set disable_coredump false" | sudo tee -a /etc/sudo.conf

WORKDIR ${HOME}
USER ${USER}

#ENTRYPOINT ["/usr/local/docker-entrypoint.sh"]
#CMD ["/usr/bin/firefox"]
# CMD ["/usr/bin/google-chrome","--no-sandbox","--disable-gpu", "--disable-extensions"]
#CMD ["/usr/bin/google-chrome"]

# -- test --
CMD xeyes

