#!/bin/bash
x=1
while [ $x -le 1000 ]; do
  PortNr=$((10000+x))
  PrinterNr=${PortNr#1}
  x=$((x+1))
  lpadmin -p Printer_$PrinterNr -E -v socket://192.168.33.3:$PortNr/
done
