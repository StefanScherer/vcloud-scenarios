# 100mb-test
Test the transfer of 100 MByte between two VMs in both directions.

The following boxes will be created

* `server`
* `client`

## vCloud

First spin up both boxes in your vCloud with

```bash
vagrant up --provider=vcloud
```

### Test 1: Send 100 MByte locally in one box

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
==> server: External IP for server: 10.100.50.4
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.13.0-36-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
New release '14.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Wed Oct  1 08:26:03 2014 from 192.168.186.1
vagrant@server:~$ /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 22.6425 s, 4.6 MB/s

real  0m22.701s
user  0m0.050s
sys   0m22.288s
+ md5sum bigfile-urandom
8516c82fb881e2aee0b60dd526385369  bigfile-urandom
vagrant@server:~$ /vagrant/scripts/receiver.sh &
[1] 1235
vagrant@server:~$ + nc -d -l 12345
/vagrant/scripts/send-to-localhost.sh
+ nc 127.0.0.1 12345
+ cat bigfile-urandom

real  0m0.857s
user  0m0.013s
sys   0m0.182s
vagrant@server:~$ + md5sum xxx.data
8516c82fb881e2aee0b60dd526385369  xxx.data
```

### Test 2: Send 100 MByte between two boxes

For this test we start a netcat receiver listening on port 12345
on the server VM.

```bash
vagrant ssh server -c /vagrant/scripts/receiver.sh
```

Open up another shell and send the file from client to server.

```bash
vagrant ssh client -c /vagrant/scripts/setup.sh
vagrant ssh client -c /vagrant/scripts/send-to-server.sh
```

Example output:

```
$ vagrant ssh client -c /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 21.2073 s, 4.9 MB/s

real  0m21.270s
user  0m0.041s
sys   0m20.711s
+ md5sum bigfile-urandom
b3c70eca4c6e4eb97fc6ad5a249eeeb7  bigfile-urandom
Connection to 10.100.50.4 closed.
vagrant at vpn-mac in ~/code/vcloud-scenarios/100mb-test on master
$ vagrant ssh client -c /vagrant/scripts/send-to-server.sh
+ nc 192.168.33.2 12345
+ cat bigfile-urandom

real  0m1.073s
user  0m0.032s
sys   0m0.346s
Connection to 10.100.50.4 closed.
```

### Test 3: Send 100 MByte from client to server and back

For this test we start a simple spooler process that receives data
from port 12345 and writes it on disk. Then it sends the data back over
the network to the client.

The client measures the time until the data has been received again.

```bash
vagrant ssh server -c /vagrant/scripts/spooler.sh
```

Open another shell and start the test job

```bash
vagrant ssh client
/vagrant/scripts/setup.sh
/vagrant/scripts/sendrec.sh
```

Example output:

```
$ vagrant ssh client
==> client: External IP for client: 10.100.50.4
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.13.0-36-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
New release '14.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Fri Oct  3 00:13:15 2014 from 192.168.99.118
vagrant@client:~$ /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 21.4557 s, 4.9 MB/s

real	0m21.468s
user	0m0.034s
sys	0m20.524s
+ md5sum bigfile-urandom
14a8c72842b01fde86bfd053bd95e088  bigfile-urandom
vagrant@client:~$ /vagrant/scripts/sendrec.sh
+ /vagrant/scripts/send-to-server.sh
+ /vagrant/scripts/receiver.sh
+ nc -d -l 12345
+ nc 192.168.33.2 12345
+ cat bigfile-urandom

real  0m1.242s
user  0m0.023s
sys   0m0.338s
vagrant@client:~$ + md5sum xxx.data
14a8c72842b01fde86bfd053bd95e088  xxx.data

real  0m2.450s
user  0m0.236s
sys   0m0.652s
```

## VirtualBox

You can run the tests locally in VirtualBox

```bash
$ vagrant up --provider=virtualbox
```

This will spin up two boxes with a private network 192.168.33.x in between the two boxes.

### Test 1
server local

```
$ vagrant ssh server
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.13.0-36-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
New release '14.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Tue Sep 30 18:19:29 2014 from 10.0.2.2
vagrant@server:~$ /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 6.11678 s, 17.1 MB/s

real  0m6.127s
user  0m0.028s
sys   0m6.044s
+ md5sum bigfile-urandom
d0c1f9c2226d8b7cd35bb29a5df1e2ee  bigfile-urandom
vagrant@server:~$ /vagrant/scripts/receiver.sh &
[1] 1582
vagrant@server:~$ + nc -d -l 12345
/vagrant/scripts/s/vagrant/scripts/send-to-localhost.sh
+ nc 127.0.0.1 12345
+ cat bigfile-urandom

real  0m0.385s
user  0m0.010s
sys   0m0.137s
vagrant@server:~$ + md5sum xxx.data
d0c1f9c2226d8b7cd35bb29a5df1e2ee  xxx.data
```

### Test 2
client -> server

```
$ vagrant ssh client -c /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 6.01086 s, 17.4 MB/s

real  0m6.023s
user  0m0.000s
sys   0m5.957s
+ md5sum bigfile-urandom
641643a0ae2c1c571ebf040bbd2b7ada  bigfile-urandom
Connection to 127.0.0.1 closed.
~/code/vcloud-scenarios/100mb-test on master*
$ vagrant ssh client -c /vagrant/scripts/send-to-server.sh
+ nc 192.168.33.2 12345
+ cat bigfile-urandom

real  0m1.319s
user  0m0.005s
sys   0m0.385s
Connection to 127.0.0.1 closed.
```

### Test 3

client -> server -> client

```
$ vagrant ssh client
Welcome to Ubuntu 12.04.5 LTS (GNU/Linux 3.13.0-36-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
New release '14.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

Last login: Fri Oct  3 00:05:34 2014 from 10.0.2.2
vagrant@client:~$ /vagrant/scripts/setup.sh
+ dd if=/dev/urandom of=bigfile-urandom bs=1024 count=102400
102400+0 records in
102400+0 records out
104857600 bytes (105 MB) copied, 6.01107 s, 17.4 MB/s

real  0m6.025s
user  0m0.016s
sys   0m5.973s
+ md5sum bigfile-urandom
a2f6c5ee6069ec1bc32d1c35dc2a1c4e  bigfile-urandom
vagrant@client:~$ /vagrant/scripts/sendrec.sh
+ /vagrant/scripts/receiver.sh
+ /vagrant/scripts/send-to-server.sh
+ nc -d -l 12345
+ nc 192.168.33.2 12345
+ cat bigfile-urandom

real  0m2.795s
user  0m0.008s
sys   0m2.193s
vagrant@client:~$ + md5sum xxx.data
a2f6c5ee6069ec1bc32d1c35dc2a1c4e  xxx.data

real  0m5.107s
user  0m0.219s
sys   0m1.584s
```
