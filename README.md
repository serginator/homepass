homepass
========

For ubuntu. Tested in *Ubuntu 14.04*.
Just execute `homepass.sh` in your shell.
It will download some dependencies if it needs them (hostapd, ap-hotspot) and in that case it will reboot 
the system to make those utilities work correctly.

The script will cycle through the most common MAC addresses of nintendo zones (4e:53:50:4f:4f:40 to 4e:53:50:4f:4f:4F)
half an hour per MAC, so when you start again with :40, 8 hours later, the access will be refreshed. Theoretically
you will get streetpasses every 8 hours.

Done while talking with @duke_srg in [GBATemp](https://gbatemp.net/threads/how-to-have-a-homemade-streetpass-relay.352645/page-215#post-5214235)
