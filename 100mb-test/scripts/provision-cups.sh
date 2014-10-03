#!/bin/bash

# install cups
sudo apt-get update -y
sudo apt-get install -y cups

# enable printer admin
# cupsctl --remote-admin
cupsctl --share-printers

# enable LPD
# from http://manpages.ubuntu.com/manpages/jaunty/man8/cups-lpd.8.html
sudo apt-get install -y xinetd
cat <<CONFIG | sudo tee /etc/xinetd.d/cups-lpd
service printer
{
  socket_type = stream
  protocol = tcp
  wait = no
  user = lp
  group = sys
  passenv =
  server = /usr/lib/cups/daemon/cups-lpd
  server_args = -n -o document-format=application/octet-stream
}
CONFIG
sudo service xinetd restart

# create pingpong printer
lpadmin -p pingpong -E -v socket://192.168.33.3:12345/
