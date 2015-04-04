FROM        ubuntu:14.04
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
ENV REFRESHED_AT 2015-04-03

# Update system
RUN apt-get update && \
	apt-get install -y wget curl dnsutils python-pip python-dev python-apt software-properties-common dmidecode

# Setup salt ppa
RUN echo deb http://ppa.launchpad.net/saltstack/salt/ubuntu `lsb_release -sc` main | tee /etc/apt/sources.list.d/saltstack.list && \
	wget -q -O- "http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x4759FA960E27C0A6" | apt-key add -

# Install salt master/minion/cloud/api
ENV SALT_VERSION 2014.7.2+ds-1trusty2
RUN apt-get update && \
	apt-get install -y salt-master=$SALT_VERSION salt-minion=$SALT_VERSION \
	salt-cloud=$SALT_VERSION salt-api=$SALT_VERSION

# Setup halite
RUN pip install cherrypy docker-py halite

# Add salt config files
ADD etc/master /etc/salt/master
ADD etc/minion /etc/salt/minion
ADD etc/reactor /etc/salt/master.d/reactor

# Expose volumes
VOLUME ["/etc/salt", "/var/cache/salt", "/var/logs/salt", "/srv/salt"]

# Exposing salt master and api ports
EXPOSE 4505 4506 8080 8081

# Add and set start script
ADD start.sh /start.sh
CMD ["bash", "start.sh"]
