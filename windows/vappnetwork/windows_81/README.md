# windows/vappnetwork/windows_81
A small sample to bring up one windows 8.1 machine in vCloud with vagrant-vcloud provider
and Vagrant 1.6.3. The new winrm communicator is used for provisioning.

## Prerequisites

* Vagrant 1.6.3 + [PR #3962](https://github.com/frapposelli/vagrant-vcloud/pull/3962), or Vagrant 1.6.4 for `vagrant rdp` on windows hosts
* vagrant-vcloud 0.4.0
* a global Vagrantfile with your vCloud connection data

## Installation

Must have an uploaded box `windows_81` in your vCloud catalog. Append a dummy box with the following command to make vagrant happy.

```bash
vagrant box add --name windows_81 https://github.com/StefanScherer/vcloud-scenarios/raw/master/dummy_box/dummy.box
```

## Create the boxes
```bash
vagrant up --provider=vcloud
```

You can also connection with RDP

```bash
vagrant rdp tst
```

## Walkthrough

### vagrant up

On first `vagrant up --provider=vcloud` the two boxes will be created and provisioned.

