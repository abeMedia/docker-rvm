FROM ubuntu:trusty
MAINTAINER Adam Bouqdib <adam@abemedia.co.uk>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl && \
    rm -rf /var/lib/apt/lists/* && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby

# Add image configuration and scripts
ADD *.sh /
RUN chmod 755 /*.sh

RUN mkdir /app

WORKDIR /app

EXPOSE 80
CMD ["/run.sh"]