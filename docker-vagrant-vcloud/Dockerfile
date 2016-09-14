FROM ubuntu:16.04

ENV VAGRANT_VERSION 1.8.5

RUN apt-get update && apt-get install -y curl
RUN curl -o vagrant.deb https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb && \
    dpkg -i vagrant.deb && \
    rm vagrant.deb
RUN vagrant plugin install vagrant-vcloud
COPY dummy.box dummy.box
RUN vagrant box add windows_2008_r2 dummy.box && \
    vagrant box add windows_2012_r2 dummy.box && \
    vagrant box add windows_7 dummy.box && \
    vagrant box add ubuntu1204 dummy.box && \
    vagrant box add ubuntu1404 dummy.box

WORKDIR /work

# ENTRYPOINT ["vagrant"]
