FROM ubuntu:bionic

ENV TZ=UTC
ENV DEBIAN_FRONTEND=noninteractive

# install ntp, timezone settings
RUN apt-get update \
    && apt-get install ntp tzdata ntpdate ntpstat -y 
    #&& cp -f /usr/share/zoneinfo/${TZ} /etc/localtime \
    #&& echo $TZ > /etc/timezone

# use custom ntpd config file
COPY assets/ntp.conf /etc/ntp.conf

# ntp port
EXPOSE 123/udp

# let docker know how to test container health
#HEALTHCHECK CMD ntpstat || exit 1

# start ntpd in the foreground
ENTRYPOINT [ "/usr/sbin/ntpd", "-d", "5" ]

# if debugging
#ENTRYPOINT [ "/bin/bash" ]
