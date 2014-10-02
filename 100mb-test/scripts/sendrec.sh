#!/bin/bash -x
time /vagrant/scripts/receiver.sh &
/vagrant/scripts/send-to-server.sh
