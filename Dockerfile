FROM        ubuntu
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"

RUN apt-get update && \
	apt-get install -y wget curl dnsutils

RUN echo deb http://ppa.launchpad.net/saltstack/salt/ubuntu `lsb_release -sc` main | tee /etc/apt/sources.list.d/saltstack.list && \
	wget -q -O- "http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x4759FA960E27C0A6" | apt-key add -

RUN apt-get update && \
	apt-get install -y salt-master salt-minion

ADD etc/master /etc/salt/master
ADD etc/minion /etc/salt/minion
ADD etc/minion_id /etc/salt/minion_id

EXPOSE 4505
EXPOSE 4506

ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD ["bash", "start.sh"]