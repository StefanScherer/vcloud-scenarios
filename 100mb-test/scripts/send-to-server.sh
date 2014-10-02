#!/bin/bash -x
time cat bigfile-urandom | nc 192.168.33.2 12345
