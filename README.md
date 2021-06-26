# `Please consider to donate what you can to help UNICEF, WHO, and Red Cross if you like what we provide to you for free. Thanks so much!`
* [`World Health Organization (WHO) COVID-19 Solidarity Response Fund`](https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate)
* [`Help UNICEF’s COVID-19 Response`](https://donate.unicef.org/)
* [`Help Red Cross`](https://www.redcross.org/donate)

# OpenJDK Java 8/11 + Maven 3.6 + Python 3.6 + pip 20 + node 14 + npm 6.14 + Gradle 6 + X11 (Desktop GUI)
[![](https://images.microbadger.com/badges/image/openkbs/jdk-mvn-py3-x11.svg)](https://microbadger.com/images/openkbs/jdk-mvn-py3-x11 "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/jdk-mvn-py3-x11.svg)](https://microbadger.com/images/openkbs/jdk-mvn-py3-x11 "Get your own version badge on microbadger.com")

# Note
* Due to some issue in migrating from Ubuntu 18.04 to Ubuntu 20.04, this X11 Container GIT will be using Ubuntu 18.04 until the issue resolved.

# ** UPDATE **
Use OpenJDK from now on!!

# Components:
* [Base Container Image: openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3)
* [Base Components: OpenJDK, Python 3, PIP, Node/NPM, Gradle, Maven, etc.](https://github.com/DrSnowbird/jdk-mvn-py3#components)
* X11 for desktop display
* Google-Chrome + Firefox

# Pull the image from Docker Repository

```bash
docker pull openkbs/jdk-mvn-py3-x11
```

# Base the image to build add-on components

```Dockerfile
FROM openkbs/jdk-mvn-py3-x11
```

# Run the image

Then, you're ready to run:
- make sure you create your work directory, e.g., ./data

```bash
mkdir ./data
docker run -d --name my-jdk-mvn-py3-x11 -v $PWD/data:/data -i -t openkbs/jdk-mvn-py3-x11
```

# Disposal-able Web Browsers using X11 Container - one of Possible Other Usages
You can use this X11 Container as your "isolated Container for your internet browsing - while keep the safety (security) of HOST computer. And, you can just do below (in the future, a slim-version of this X11 only browsers will be created for just this purpose with security locked down removing sudo and other measures - to just use this Container as Docker-based Browser for more safety in browsing the Internet) to prevent using your HOST's PC/laptop to expose your HOST computer to
```
./run.sh firefox

or

./run.sh google-chrome --no-sandbox
```

# To lunch multiple X11 Desktop applications
Default is to show xeyes (X11 app) when using "docker-compose up" or "make up".
You can use another host's teminal to enter the Container to start run, say, Firefox or Google-Chrome:
```
./shell.sh 

(once you enter the Container - while you have another terminal have xeyes running)

firefox

or

google-chrome --no-sandbox 
```

# Build and Run your own image
Say, you will build the image "my/jdk-mvn-py3-x11".

```bash
docker build -t my/jdk-mvn-py3-x11 .
```

To run your own image, say, with some-jdk-mvn-py3-x11:

```bash
mkdir ./data
docker run -d --name some-jdk-mvn-py3-x11 -v $PWD/data:/data -i -t my/jdk-mvn-py3
```

# Shell into the Docker instance

```bash
docker exec -it some-jdk-mvn-py3-x11 /bin/bash
```

# Run Python

To run Python code

```bash
docker run -it --rm openkbs/jdk-mvn-py3-x11 python3 -c 'print("Hello World")'
```

or,

```bash
docker run -i --rm openkbs/jdk-mvn-py3-x11 python3 < myPyScript.py
```

or,

```bash
mkdir ./data
echo "print('Hello World')" > ./data/myPyScript.py
docker run -it --rm --name some-jdk-mvn-py3-x11 -v "$PWD"/data:/data openkbs/jdk-mvn-py3-x11 python3 myPyScript.py
```

or,

```bash
alias dpy3='docker run --rm openkbs/jdk-mvn-py3-x11 python3'
dpy3 -c 'print("Hello World")'
```

## Compile or Run java while no local installation needed
Remember, the default working directory, /data, inside the docker container -- treat is as "/".
So, if you create subdirectory, "./data/workspace", in the host machine and
the docker container will have it as "/data/workspace".

```java
#!/bin/bash -x
mkdir ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
alias djavac='docker run -it --rm --name some-jdk-mvn-py3-x11 -v '$PWD'/data:/data openkbs/jdk-mvn-py3-x11 javac'
alias djava='docker run -it --rm --name some-jdk-mvn-py3-x11 -v '$PWD'/data:/data openkbs/jdk-mvn-py3-x11 java'

djavac HelloWorld.java
djava HelloWorld
```
And, the output:
```
Hello, World
```
Hence, the alias above, "djavac" and "djava" is your docker-based "javac" and "java" commands and
it will work the same way as your local installed Java's "javac" and "java" commands.
However, for larger complex projects, you might want to consider to use Docker-based IDEs as listed in the later sections of this document.

# Python Virtual Environments
There are various ways to run Python virtual envrionments, for example,

### Setup virtualenvwrapper in $HOME/.bashrc profile
Add the following code to the end of ~/.bashrc
```
#########################################################################
#### ---- Customization for multiple virtual python environment ---- ####
#########################################################################
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/Envs
if [ ! -d $WORKON_HOME ]; then
    mkdir -p $WORKON_HOME
fi
```

### To create & activate your default venv environment, say, "my-venv":
```
mkvirtualenv my-venv
workon my-venv
```

# See Also - Docker-based IDE
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
* [openkbs/knime-vnc-docker](https://hub.docker.com/r/openkbs/knime-vnc-docker/)
* [openkbs/netbeans10-docker](https://hub.docker.com/r/openkbs/netbeans10-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)
* [openkbs/webstorm-vnc-docker](https://hub.docker.com/r/openkbs/webstorm-vnc-docker/)

# See Also - Docker-based SQL GUI
* [Sqlectron SQL GUI at openkbs/sqlectron-docker](https://hub.docker.com/r/openkbs/sqlectron-docker/)
* [Mysql-Workbench at openkbs/mysql-workbench](https://hub.docker.com/r/openkbs/mysql-workbench/)
* [PgAdmin4 for PostgreSQL at openkbs/pgadmin-docker](https://hub.docker.com/r/openkbs/pgadmin-docker/)

# Other Java Dev in Docker
* [Java Development in Docker](https://blog.giantswarm.io/getting-started-with-java-development-on-docker/)

# Display X11 Issue
More resource in X11 display of Eclipse on your host machine's OS, please see
* [X11 Display problem](https://askubuntu.com/questions/871092/failed-to-connect-to-mir-failed-to-connect-to-server-socket-no-such-file-or-di)
* [X11 Display with Xhost](http://www.ethicalhackx.com/fix-gtk-warning-cannot-open-display/)

# Other possible Issues
You might see the warning message in the launching xterm console like below, you can just ignore it. I googles around and some blogs just suggested to ignore since the IDE still functional ok.

# Releases information
* [See Releases Information](https://github.com/DrSnowbird/jdk-mvn-py3#releases-information)


