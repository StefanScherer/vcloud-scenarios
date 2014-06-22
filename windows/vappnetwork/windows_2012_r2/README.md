# windows/vappnetwork/windows_2012_r2
A small sample to bring up two windows machines in vCloud with vagrant-vcloud provider
and Vagrant 1.6.3. The new winrm communicator is used for provisioning.

## Prerequisites

* Vagrant 1.6.3 + [PR #3962](https://github.com/frapposelli/vagrant-vcloud/pull/3962), or Vagrant 1.6.4 for `vagrant rdp` on windows hosts
* vagrant-vcloud 0.4.0
* a global Vagrantfile with your vCloud connection data

## Known Issues

* vagrant rdp crashes on a Windows host in vagrant 1.6.3. See [Vagrant issue 3962](https://github.com/mitchellh/vagrant/issues/3962)

## Installation

Must have an uploaded box `windows_2012_r2` in your vCloud catalog. Append a dummy box with the following command to make vagrant happy.

```bash
vagrant box add --name windows_2012_r2 https://github.com/StefanScherer/vcloud-scenarios/raw/master/dummy_box/dummy.box
```

## Create the boxes
```bash
vagrant up --provider=vcloud
```

You can also connection with RDP

```bash
vagrant rdp tst
vagrant rdp tst2
```

## Walkthrough

### vagrant up

On first `vagrant up --provider=vcloud` the two boxes will be created and provisioned.
The provision script also opens the remote desktop port for further testing.

```
b:\GitHub\vcloud-win [master]>vagrant up --provider=vcloud
Bringing machine 'tst' up with 'vcloud' provider...
Bringing machine 'tst2' up with 'vcloud' provider...
==> tst: Building vApp...
==> tst: vApp vcloud-win-stefan.scherer-roenb014-bcb40c9c successfully created.
==> tst: Setting VM hardware...
==> tst: Powering on VM...
==> tst: Fixed port collision for 22 => 2222. Now on port 2206.
==> tst: Fixed port collision for 3389 => 3389. Now on port 2207.
==> tst: Fixed port collision for 5985 => 55985. Now on port 2271.
==> tst: Forwarding Ports: VM port 22 -> vShield Edge port 2206
==> tst: Forwarding Ports: VM port 3389 -> vShield Edge port 2207
==> tst: Forwarding Ports: VM port 5985 -> vShield Edge port 2271
==> tst: Creating NAT rules on [SS-EDGE] for IP [10.100.50.4] port 2206.
==> tst: Creating NAT rules on [SS-EDGE] for IP [10.100.50.4] port 2207.
==> tst: Creating NAT rules on [SS-EDGE] for IP [10.100.50.4] port 2271.
==> tst: Waiting for SSH Access on 10.100.50.4:2206 ...
==> tst: Warning! Folder sync disabled because the rsync binary is missing.
==> tst: Make sure rsync is installed and the binary can be found in the PATH.
==> tst: Running provisioner: shell...
    tst: Running: c:\tmp\vagrant-shell.ps1
==> tst: This guest box is tst (registry ComputerName)
==> tst: This guest box is TST (env COMPUTERNAME)
==> tst:
==> tst: Enable Remote Desktop
==> tst:
==> tst: Updated 1 rule(s).
==> tst: Ok.
==> tst:
==> tst: Write-Host : The OS handle's position is not what FileStream expected. Do not u
==> tst: se a handle simultaneously in one FileStream and in Win32 code or another FileS
==> tst: tream. This may cause data loss.
==> tst: At C:\tmp\vagrant-shell.ps1:21 char:11
==> tst: + Write-Host <<<<  "Provisioning done"
==> tst:     + CategoryInfo          : NotSpecified: (:) [Write-Host], IOException
==> tst:     + FullyQualifiedErrorId : System.IO.IOException,Microsoft.PowerShell.Comma
==> tst2: Adding VM to existing vApp...
==> tst2: Setting VM hardware...
==> tst2: Powering on VM...
==> tst2: Fixed port collision for 22 => 2222. Now on port 2272.
==> tst2: Fixed port collision for 3389 => 3389. Now on port 2273.
==> tst2: Fixed port collision for 5985 => 55985. Now on port 2274.
==> tst2: Forwarding Ports: VM port 22 -> vShield Edge port 2272
==> tst2: Forwarding Ports: VM port 3389 -> vShield Edge port 2273
==> tst2: Forwarding Ports: VM port 5985 -> vShield Edge port 2274
==> tst2: Creating NAT rules on [SS-EDGE] for IP [10.100.50.4] port 2272.
==> tst2: Creating NAT rules on [SS-EDGE] for IP [10.100.50.4] port 2273.
==> tst2: Creating NAT rules on [SS-EDGE] for IP [10.100.50.4] port 2274.
==> tst2: Waiting for SSH Access on 10.100.50.4:2272 ...
==> tst2: Warning! Folder sync disabled because the rsync binary is missing.
==> tst2: Make sure rsync is installed and the binary can be found in the PATH.
==> tst2: Running provisioner: shell...
    tst2: Running: c:\tmp\vagrant-shell.ps1
==> tst2: This guest box is tst2 (registry ComputerName)
==> tst2: This guest box is TST2 (env COMPUTERNAME)
==> tst2: Enable Remote Desktop
==> tst2:
==> tst2: Updated 1 rule(s).
==> tst2: Ok.
==> tst2:
==> tst2: Write-Host : The OS handle's position is not what FileStream expected. Do not u
==> tst2: se a handle simultaneously in one FileStream and in Win32 code or another FileS
==> tst2: tream. This may cause data loss.
==> tst2: At C:\tmp\vagrant-shell.ps1:21 char:11
==> tst2: + Write-Host <<<<  "Provisioning done"
==> tst2:     + CategoryInfo          : NotSpecified: (:) [Write-Host], IOException
==> tst2:     + FullyQualifiedErrorId : System.IO.IOException,Microsoft.PowerShell.Comma
```

## vagrant status

Show the status of the boxes with `vagrant status`

```
b:\GitHub\vcloud-win [master*]>vagrant status
Current machine states:

tst                       running (vcloud)
tst2                      running (vcloud)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

## vagrant vcloud -n

Show the port forwardings with `vagrant vcloud -n`

```
b:\GitHub\vcloud-win [master*]>vagrant vcloud -n
Initializing vCloud Director provider...
Fetching vCloud Director network settings ...
+------------------------------------+----------------------------------------------------------+---------+
|                                   Vagrant vCloud Director Network Map                                   |
+------------------------------------+----------------------------------------------------------+---------+
| VM Name                            | Destination NAT Mapping                                  | Enabled |
+------------------------------------+----------------------------------------------------------+---------+
| tst2                               | 10.100.50.4:2272 -> 10.115.4.4:2272 -> 192.168.33.3:22   | true    |
| tst2                               | 10.100.50.4:2273 -> 10.115.4.4:2273 -> 192.168.33.3:3389 | true    |
| tst2                               | 10.100.50.4:2274 -> 10.115.4.4:2274 -> 192.168.33.3:5985 | true    |
| tst                                | 10.100.50.4:2206 -> 10.115.4.4:2206 -> 192.168.33.2:22   | true    |
| tst                                | 10.100.50.4:2207 -> 10.115.4.4:2207 -> 192.168.33.2:3389 | true    |
| tst                                | 10.100.50.4:2271 -> 10.115.4.4:2271 -> 192.168.33.2:5985 | true    |
+------------------------------------+----------------------------------------------------------+---------+
| Network Name                       | Source NAT Mapping                                       | Enabled |
+------------------------------------+----------------------------------------------------------+---------+
| VM1-extern                         | 10.115.4.4 -> 10.100.50.4                                | true    |
+------------------------------------+----------------------------------------------------------+---------+
| Rule# - Description                | Firewall Rules                                           | Enabled |
+------------------------------------+----------------------------------------------------------+---------+
| 1 - (Allow Vagrant Communications) | allow SRC:Any:Any to DST:10.100.50.4:Any                 | true    |
+------------------------------------+----------------------------------------------------------+---------+
```

## vagrant rdp

Now it's time to connect to the boxes.

```
b:\GitHub\vcloud-win [master*]>vagrant rdp tst
==> tst: Detecting RDP info...
    tst: Address: 10.100.50.4:2207
    tst: Username: vagrant
==> tst: Vagrant will now launch your RDP client with the connection parameters
==> tst: above. If the connection fails, verify that the information above is
==> tst: correct. Additionally, make sure the RDP server is configured and
==> tst: running in the guest machine (it is disabled by default on Windows).
==> tst: Also, verify that the firewall is open to allow RDP connections.

b:\GitHub\vcloud-win [master*]>vagrant rdp tst2
==> tst2: Detecting RDP info...
    tst2: Address: 10.100.50.4:2273
    tst2: Username: vagrant
==> tst2: Vagrant will now launch your RDP client with the connection parameters
==> tst2: above. If the connection fails, verify that the information above is
==> tst2: correct. Additionally, make sure the RDP server is configured and
==> tst2: running in the guest machine (it is disabled by default on Windows).
==> tst2: Also, verify that the firewall is open to allow RDP connections.
```

As you can see, each box has it's own port forwarding for RDP and `vagrant rdp` gently opens the RDP connection through your vCloud Edge gateway and vApp network into your VM.

