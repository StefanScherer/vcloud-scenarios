#!/bin/bash -x
time cat bigfile-urandom | nc 127.0.0.1 12345
