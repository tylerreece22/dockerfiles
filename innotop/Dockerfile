# https://github.com/leonis/innotop-on-docker
# https://linux.die.net/man/1/innotop
FROM oraclelinux:8-slim

ARG MYSQL_SERVER_PACKAGE=mysql-community-server-minimal-8.0.26
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.26

# Setup repositories for minimal packages (all versions)
RUN rpm -U https://repo.mysql.com/mysql-community-minimal-release-el8.rpm \
  && rpm -U https://repo.mysql.com/mysql80-community-release-el8.rpm

# Install server and shell 8.0
RUN microdnf update && echo "[main]" > /etc/dnf/dnf.conf \
  && microdnf install -y $MYSQL_SHELL_PACKAGE \
  && microdnf install -y --disablerepo=ol8_appstream \
   --enablerepo=mysql80-server-minimal $MYSQL_SERVER_PACKAGE \
  && microdnf clean all \
  && mkdir /docker-entrypoint-initdb.d

VOLUME /Users/tylerreece/Documents/docker-volumes:/var/lib/mysql

COPY prepare-image.sh /
RUN /prepare-image.sh && rm -f /prepare-image.sh

ENV MYSQL_UNIX_PORT /var/lib/mysql/mysql.sock
ENV MYSQL_ROOT_PASSWORD=password

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 3306 33060 33061
CMD ["mysqld"]

# Install innotop and dependencies
RUN apt -y update \
  && apt -y upgrade \
  && apt -y install make \
  && apt -y install wget libterm-readkey-perl libapache-dbi-perl libdbd-mysql-perl libextutils-makemaker-cpanfile-perl libtime-hires-perl \
  && apt clean all

WORKDIR /var

RUN wget https://github.com/innotop/innotop/archive/v1.11.1.tar.gz \
  && tar xvzf v1.11.1.tar.gz \
  && cd ./innotop-1.11.1 \
  && perl Makefile.PL \
  && make install \
  && cd ../ \
  && rm -rf ./innotop-1.11.1 ./v1.11.1.tar.gz

ENTRYPOINT ["/usr/local/bin/innotop", "-h", "localhost", "-P", "3306", "-u", "root", "-p", "password", "/run/mysqld/mysqld.sock"]