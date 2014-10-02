#!/bin/bash -x
nc -d -l 12345 > xxx.data
md5sum xxx.data
