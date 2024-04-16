FROM        continuumio/miniconda3
LABEL       MAINTAINER="Akhlak Mahmood <akhlakm@gatech.edu>"

#           Use nginx for reverse proxy and static files handler.
# RUN         apt-get -y update && apt-get -y install vim

#           Set required env variables.
ENV         MPLCONFIGDIR=/tmp/matplotlib
ENV         TZ=America/New_York
ENV         MNTVOL=/data
ENV         WEBSERVER_HOST_PORT=127.0.0.1:8000
EXPOSE      8000

#           Catch this to stop the running server.
STOPSIGNAL  SIGTERM

#           Create non-root user. Use ID: 1000830000
ARG         USERID=1000830000
RUN         groupadd -g $USERID apps
RUN         useradd -l -m -u $USERID -g apps apps

#           Copy all files.
COPY        . /home/apps
WORKDIR     /home/apps

#           Update permission.
RUN         chmod +x entry.sh
RUN         chown -R apps /home/apps

#           Hand over to non-root user.
USER        apps

ENTRYPOINT  ["/bin/bash", "entry.sh"]
