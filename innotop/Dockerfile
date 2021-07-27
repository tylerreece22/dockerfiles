# https://github.com/leonis/innotop-on-docker
# https://linux.die.net/man/1/innotop
FROM mysql:latest
ENV MYSQL_ROOT_PASSWORD=password
VOLUME /Users/tylerreece/Documents/docker-volumes:/var/lib/mysql
EXPOSE 3306:3306

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