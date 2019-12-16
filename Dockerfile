FROM ubuntu

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN echo 'APT::Install-Recommends "0"; \n\
APT::Get::Assume-Yes "true"; \n\
APT::Get::allow-downgrades "true"; \n\
APT::Get::allow-remove-essential "true"; \n\
APT::Get::allow-change-held-packages "true"; \n\
APT::Install-Suggests "0";' > /etc/apt/apt.conf.d/01buildconfig

RUN mkdir -p  /etc/apt/sources.d/ \
      && apt-get update \
      && apt-get install apt-utils

# RUN apt-get install systemd
#
# RUN cd /lib/systemd/system/sysinit.target.wants/; \
#       ls | grep -v systemd-tmpfiles-setup | xargs rm -vf $1 \
#       rm -vf /lib/systemd/system/multi-user.target.wants/*;\
#       rm -vf /etc/systemd/system/*.wants/*;\
#       rm -vf /lib/systemd/system/local-fs.target.wants/*; \
#       rm -vf /lib/systemd/system/sockets.target.wants/*udev*; \
#       rm -vf /lib/systemd/system/sockets.target.wants/*initctl*; \
#       rm -vf /lib/systemd/system/basic.target.wants/*;\
#       rm -vf /lib/systemd/system/anaconda.target.wants/*; \
#       rm -vf /lib/systemd/system/plymouth*; \
#       rm -vf /lib/systemd/system/systemd-update-utmp*;
#
# RUN systemctl set-default multi-user.target
#
# ENV init /lib/systemd/systemd
#
# VOLUME [ "/sys/fs/cgroup" ]
#
#
RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man/:' \
        /etc/dpkg/dpkg.cfg.d/excludes

RUN apt-get install -y \
      manpages \
      manpages-posix \
      man-db \
      ssh \
      syslog-ng \
      rsync \
      runit 

RUN apt-get install -y \
      build-essential \
      manpages-dev \
      git \
      tmux \
      screen \
      vim \
      rar \
      unrar \
      zip \
      unzip \
      p7zip-full \
      par2 \
      whois \
      traceroute \
      nmap \
      less 




RUN mkdir -p /app /run/sshd /host_etc

COPY app /app

RUN find /app -name run | xargs chmod a+rx 

# RUN apt-get clean \
#       && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

CMD ["runsvdir", "/app"]
