if [ ! -f /etc/resolvconf/resolv.conf.d/tail ]; then
  echo "nameserver 10.100.20.2" | tee -a /etc/resolvconf/resolv.conf.d/tail
  echo "nameserver 8.8.8.8" | tee -a /etc/resolvconf/resolv.conf.d/tail
  resolvconf -u
fi