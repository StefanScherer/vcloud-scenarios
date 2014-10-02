# 100mb-test
Test the transfer of 100 MByte between two VMs in both directions.

The following boxes will be created

* `server`
* `client`

First spin up both boxes in your vCloud with

```bash
vagrant up --provider=vcloud
```

## Send 100 MByte locally in one box

For this test we log into one box, eg. the server VM.

```bash
vagrant ssh server
/vagrant/scripts/setup.sh
/vagrant/scripts/receiver.sh &
/vagrant/scripts/send-to-localhost.sh
```

Example output:
```
$ vagrant ssh server
Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-32-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Sat Aug 16 21:06:35 2014 from 192.168.254.1
vagrant@server:~$ /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 9.19238 s, 11.4 MB/s

real	0m9.195s
user	0m0.070s
sys	0m9.086s
+ md5sum bigfile-urandom
a2329ed959f1fd4da7ffe63d9bc21067  bigfile-urandom
vagrant@server:~$ /vagrant/scripts/receiver.sh &
[1] 2054
vagrant@server:~$ + nc -d -l 12345
/vagrant/scripts/send-to-localhost.sh
+ cat bigfile-urandom
+ nc 127.0.0.1 12345

real	0m0.937s
user	0m0.041s
sys	0m0.140s
vagrant@server:~$ + md5sum xxx.data
a2329ed959f1fd4da7ffe63d9bc21067  xxx.data

[1]+  Done                    /vagrant/scripts/receiver.sh
vagrant@server:~$
```

## Send 100 MByte between two boxes

For this test we start a netcat receiver listening on port 12345
on the server VM.

```bash
vagrant ssh server -c /vagrant/scripts/receiver.sh
```

Open up another shell and send the file from client to server.

```bash
vagrant ssh client -c /vagrant/scripts/send-to-server.sh
```

Example output:

```
$ vagrant ssh client -c /vagrant/scripts/send-to-server.sh
+ nc 172.16.32.2 12345
+ cat bigfile-urandom

real  0m1.721s
user  0m0.037s
sys 0m1.134s
Connection to 10.100.50.4 closed.
```
