#!/bin/bash -x
while [ 1 ]
do
  nc -d -l 12345 > xxx.data
  cat xxx.data | nc 192.168.33.3 12345
  rm xxx.data
done
