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

RUN apt-get install -y apt-utils packagekit-gtk3-module libcanberra-gtk3-module
RUN apt-get install -y dbus-x11 
RUN apt-get install -y xdg-utils --fix-missing

## ---- user: developer ----
ENV USER=${USER:-developer}

ENV USER_NAME=${USER}
ENV HOME=/home/${USER}

COPY scripts $HOME/scripts
RUN sudo chown -R $USER:$USER $HOME/scripts && chmod +x $HOME/scripts/*.sh

## ---- Firefox ----
RUN sudo apt-get remove firefox -y && $HOME/scripts/firefox.sh

##  ---- Google Chromium Browser ----
RUN echo "Install Google Chromium Browser" && \
    sudo apt-get install -y libindicator3-7 indicator-application libnss3-nssdb libnss3 libnspr4 libappindicator3-1 fonts-liberation && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    sudo dpkg -i google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb && \
    which google-chrome && \
    echo "CHROMIUM_FLAGS='--no-sandbox --start-maximized --user-data-dir'" | tee ${HOME}/.chromium-browser.init

##  ---- dbus setup ----
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
ENV unix:runtime=yes
RUN sudo rm -f /var/run/firefox-restart-required && \
    #sudo mkdir -p /var/run/dbus/system_bus_socket && chmod -R 0777 /var/run/dbus/system_bus_socket && \
    #sudo mkdir -p /host/run/dbus/system_bus_socket && chmod -R 0777 /host/run/dbus/system_bus_socket && \
    sudo ln -s ${HOME}/scripts/docker-entrypoint.sh /usr/local/docker-entrypoint.sh

WORKDIR ${HOME}
USER ${USER}

#ENTRYPOINT ["/usr/local/docker-entrypoint.sh"]
#CMD ["/usr/bin/firefox"]
CMD ["/usr/bin/google-chrome","--no-sandbox","--disable-extensions"]

