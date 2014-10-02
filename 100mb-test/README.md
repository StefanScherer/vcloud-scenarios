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

## Send 100 MByte between two boxes

For this test we start a netcat receiver listening on port 12345 on the server VM.

```bash
vagrant ssh server -c /vagrant/scripts/receiver.sh
```

Then we send the file from client to server.

```bash
vagrant ssh client -c /vagrant/scripts/send-to-server.sh
```
