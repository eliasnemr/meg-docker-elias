FROM ubuntu:latest

ENV HOME=/home/minima
ENV DAPPS=$HOME/dapps
ENV LOCAL=/usr/local

WORKDIR $LOCAL

# groupadd: adds an entry for the new group to the /etc/group and /etc/gshadow files.
# useradd: -r system user, -u userid, -g group id to join, -d homeDir assignment, $name
#CREATE MINIMA USER IN UBUNTU
RUN groupadd -g 1010 minima
RUN useradd -r -u 1010 -g 1010 -d $HOME minima

#prompt -y says yes to everything when installing packages
#INSTALL OPENJDK-11 AND OTHER
RUN apt-get update && \
  apt-get install -y openjdk-11-jre-headless curl && \
  apt-get clean;

# Copy in startup script, minima and dapps
COPY scripts/installDapps.sh installDapps.sh
COPY jar/minima.jar minima/minima.jar
COPY dapps/block.minidapp $DAPPS/block.minidapp
COPY dapps/wallet.minidapp $DAPPS/wallet.minidapp
COPY dapps/terminal.minidapp $DAPPS/terminal.minidapp
COPY dapps/emh.minidapp $DAPPS/emh.minidapp
COPY sleep-script.sh sleep-script.sh

# Get other permissions right, too
RUN mkdir $HOME/.minima && \
  chown -R minima:minima $HOME && \
  chmod 700 $LOCAL/installDapps.sh

VOLUME /home/minima/.minima

# Minima ports
# EXPOSE 9001 9002 9003 9004 

# CREATE USER 'minima'@'flash_mysql' IDENTIFIED BY 'Minima123?'; GRANT ALL PRIVILEGES ON *.* TO 'minima'@'flash_mysql' WITH GRANT OPTION; FLUSH PRIVILEGES;
# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' containerID (GET CONTAINERS IP)


# And run stuff...
CMD bash sleep-script.sh && \
  su -c "java -jar minima/minima.jar -mysql root:Minima123?@flash_mysql" minima && \
  bash -c "/usr/local/installDapps.sh > install.out 2>&1"