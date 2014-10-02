#!/bin/bash -x
time dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
md5sum bigfile-urandom
