#!/bin/bash -x
/vagrant/script/setup.sh
/vagrant/scripts/receiver.sh &
/vagrant/scripts/sender.sh
