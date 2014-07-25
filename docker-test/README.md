# docker-test
This is inspired by the GoSDDC article [Dock Your Container on VMware With Vagrant and Docker](http://gosddc.com/articles/dock-your-container-on-vmware-with-vagrant-and-docker/) and uses an ubuntu1404 box to create an vApp with one box and uses the docker provisioner of Vagrant 1.6.

## Known Issues
Building a Ubuntu 14.04 box for vCloud is not so simple at the moment. Even after a trick with a symlink `etc/dhcp3` to `etc/dhcp` the `/etc/resolv.conf` contains no DNS server. So I had to add a shell provision script to fix this.
Propably a future version of vCloud does the Guest Customization better and these steps could be removed again.

## Dock your vCloud
So, it's show time. Just build the vApp with

```
vagrant up --provider=vcloud
```

This creates an Ubuntu 14.04 box with latest Docker installed. Then it starts a `tutum/wordpress` Docker container. The HTTP port will be forwarded, so you can access the Wordpress from the outside of your vCloud through vCloud Edge Gateway.

Have fun!