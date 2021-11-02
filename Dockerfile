FROM debian:buster

# Cortex
EXPOSE 8080

# GRPC
EXPOSE 8090 

# Elasticsearch
EXPOSE 9200 

RUN apt-get update | true && apt-get install -y \
    locales man-db build-essential make cmake gcc g++ \
    sudo rename unzip git \
    vim ranger screen rsync curl wget

RUN echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        openjdk-8-jre openjdk-8-jdk maven

    #     \
    #     libopencv-dev \
    #     build-essential software-properties-common gfortran cmake
    #     python-pip python3 python3-pip python3-venv \

# RUN pip3 install --upgrade pip black pylint

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

RUN wget -O elasticsearch.deb https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.13.3-amd64.deb \
    && wget -O kibana.deb https://artifacts.elastic.co/downloads/kibana/kibana-7.13.3-amd64.deb

RUN dpkg -i elasticsearch.deb \
    && rm elasticsearch.deb \
    && dpkg -i kibana.deb \
    && rm kibana.deb \
    && /bin/systemctl daemon-reload \
    && /bin/systemctl enable kibana.service \
    && /bin/systemctl enable elasticsearch.service

RUN useradd -ms /bin/bash developer \
    && usermod -aG sudo developer \
    && echo "root:root" | chpasswd \
    && echo "developer:developer" | chpasswd

# Set the locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# # Needed for things like 'source' (alternatively use .)
# SHELL ["/bin/bash", "-c"]

USER developer
WORKDIR /mnt

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
    && mkdir ~/.m2

# If an aliases.sh file exists in the directory we start up in, then source it.
RUN echo "if [ -f aliases.sh ]; then . aliases.sh; fi" >> ~/.bashrc
