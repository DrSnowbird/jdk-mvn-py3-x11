# OpenJDK Java 8 (1.8.0_222) JDK + Maven 3.6 + Python 3.6/2.7 + pip 19 + node 12 + npm 6 + Gradle 5.6 + X11 (display GUI)
[![](https://images.microbadger.com/badges/image/openkbs/jdk-mvn-py3-x11.svg)](https://microbadger.com/images/openkbs/jdk-mvn-py3-x11 "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/jdk-mvn-py3-x11.svg)](https://microbadger.com/images/openkbs/jdk-mvn-py3-x11 "Get your own version badge on microbadger.com")

# ** UPDATE **
Use OpenJDK from now on!!

# Components:
* openjdk version "1.8.0_222"
  OpenJDK Runtime Environment (build 1.8.0_222-8u222-b10-1ubuntu1~18.04.1-b10)
  OpenJDK 64-Bit Server VM (build 25.222-b10, mixed mode)
* Apache Maven 3.6
* Python 3.6 / Python 2.7 + pip 19.2 + Python3 virtual environments (venv, virtualenv, virtualenvwrapper, mkvirtualenv, ..., etc.)
* Node v12.10.0 + npm 6.10.2 (from NodeSource official Node Distribution)
* Gradle 5.6
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy, ..., etc.
* X11 for desktop display

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
However, for larger complex projects, you might want to consider to use Docker-based IDE.


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
```
developer@7e8aaadf4868:~$ /usr/scripts/printVersions.sh 
+ echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
+ java -version
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-8u222-b10-1ubuntu1~18.04.1-b10)
OpenJDK 64-Bit Server VM (build 25.222-b10, mixed mode)
+ mvn --version
Apache Maven 3.6.2 (40f52333136460af0dc0d7232c0dc0bcf0d9e117; 2019-08-27T15:06:16Z)
Maven home: /usr/apache-maven-3.6.2
Java version: 1.8.0_222, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "5.0.0-27-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.15rc1
+ python3 -V
Python 3.6.7
+ pip --version
pip 19.2.3 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ pip3 --version
pip 19.2.3 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ gradle --version

Welcome to Gradle 5.6.2!

Here are the highlights of this release:
 - Incremental Groovy compilation
 - Groovy compile avoidance
 - Test fixtures for Java projects
 - Manage plugin versions via settings script

For more details see https://docs.gradle.org/5.6.2/release-notes.html


------------------------------------------------------------
Gradle 5.6.2
------------------------------------------------------------

Build time:   2019-09-05 16:13:54 UTC
Revision:     55a5e53d855db8fc7b0e494412fc624051a8e781

Kotlin:       1.3.41
Groovy:       2.5.4
Ant:          Apache Ant(TM) version 1.9.14 compiled on March 12 2019
JVM:          1.8.0_222 (Private Build 25.222-b10)
OS:           Linux 5.0.0-27-generic amd64

+ npm -v
6.10.3
+ node -v
v12.10.0
+ cat /etc/lsb-release /etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.2 LTS"
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

