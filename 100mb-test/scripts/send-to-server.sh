#!/bin/bash -x
time cat bigfile-urandom | nc 172.16.32.2 12345
