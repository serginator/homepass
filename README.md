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

### oneliners

If you execute `source .3ds-oneliners` you will add several aliases starting with 3ds
in case you want to focus on a game. For example, `3ds-pokemon-xy-oras` will start a hotspot
for pokemon following this [guide of MACs](https://docs.google.com/spreadsheet/ccc?key=0AvvH5W4E2lIwdEFCUkxrM085ZGp0UkZlenp6SkJablE&usp=drive_web#gid=0).

The aliases are the following:
+ 3ds-SuperSmashBros
+ 3ds-eShop
+ 3ds-empty
+ 3ds-zelda-albw
+ 3ds-inazumaEleven
+ 3ds-pokemon-xy-oras
+ 3ds-all
+ 3ds-acnl-tomodachi-fantasy-life
+ 3ds-fireEmblem-eo4-smt4
+ 3ds-monsterHunter
+ 3ds-finalFantasy
+ 3ds-kidIcarus
+ 3ds-bravelyDefault-second
+ 3ds-samuraiWariors
+ 3ds-korg
+ 3ds-denpaMen

To add the oneliners on startup please execute just once `./installOneliners.sh`.
It will add the `.3ds-oneliners` file to your home, append it to `.bashrc`
and source it.

