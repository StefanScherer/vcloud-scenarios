#!/bin/bash -x
while [ 1 ]
do
  nc -d -l 12345 > xxx.data
  cat xxx.data | nc 172.16.32.3 12345
  rm xxx.data
done
