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

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/


# python-pip python3 python3-pip python3-venv \
# RUN pip3 install --upgrade pip black pylint

# # mount
# RUN ln -s /usr/bin/git-crypt /usr/local/bin/git-crypt \
#     && ln -s /media/data/home /home/derek
# 
# RUN useradd -s /bin/bash derek && \
#     usermod -aG sudo derek && \
#     echo "root:root" | chpasswd && \
#     echo "derek:derek" | chpasswd
# 
# # chown -R derek:derek /opt/python

RUN useradd -ms /bin/bash developer && \
    usermod -aG sudo developer && \
    echo "root:root" | chpasswd && \
    echo "developer:developer" | chpasswd

# Set the locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

USER developer

# # Needed for things like 'source'
# SHELL ["/bin/bash", "-c"]

WORKDIR /mnt
