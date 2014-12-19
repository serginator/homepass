#!/bin/bash

echo "###########################################################"
echo "#           serginator's Homepass MAC cycler              #"
echo "#                   - @serginator -                       #"
echo "#                     17-12-2014                          #"
echo "###########################################################"
echo "# This script will cycle through the main macs, and will  #"
echo "#    finish in 8 hours, half an hour per mac, so when     #"
echo "#  finished cycling you can cycle again and your 3DS will #"
echo "#                   work in each one                      #"
echo "###########################################################"
echo ""

PWD=`pwd`
waittime=1800
oldmac=`cat /sys/class/net/wlan0/address`
macs=(
    "4e:53:50:4f:4f:40" "4e:53:50:4f:4f:41" "4e:53:50:4f:4f:42" "4e:53:50:4f:4f:43"
    "4e:53:50:4f:4f:44" "4e:53:50:4f:4f:45" "4e:53:50:4f:4f:46" "4e:53:50:4f:4f:47"
    "4e:53:50:4f:4f:48" "4e:53:50:4f:4f:49" "4e:53:50:4f:4f:4A" "4e:53:50:4f:4f:4B"
    "4e:53:50:4f:4f:4C" "4e:53:50:4f:4f:4D" "4e:53:50:4f:4f:4E" "4e:53:50:4f:4f:4F"
)

function cleanup {
    echo "Resetting mac address";
    sudo ifconfig wlan0 down hw ether "$oldmac" up;
    echo "Stopping ap-hotspot";
    sudo ap-hotspot stop;
    sudo killall hostapd
}
trap cleanup EXIT

echo "Checking dependencies..."
# Check if ap-hotspot is installed, if not, add repo and install
type ap-hotspot >/dev/null 2>&1 || { 
    echo >&2 "Downgrading hostapd";
    sudo apt-get remove -y --force-yes  hostapd;
    cd ~/tmp;
    wget http://archive.ubuntu.com/ubuntu/pool/universe/w/wpa/hostapd_1.0-3ubuntu2.1_amd64.deb;
    sudo dpkg -i hostapd*.deb;
    sudo apt-mark hold hostapd;
    cd $PWD;
    echo >&2 "Installing ap-hotspot";
    sudo add-apt-repository -y ppa:nilarimogard/webupd8;
    sudo apt-get update;
    sudo apt-get install -y ap-hotspot;
    sudo killall hostapd;
    echo >&2 "Please fill the default settings for ap-hotspot."
    sudo ap-hotspot configure;
    echo >&2 "Writing config file in /etc/ap-hotspot.conf file";
    echo "    interface=wlan0
    driver=nl80211
    ssid=NZ@McD1
    channel=1
    macaddr_acl=1
    accept_mac_file=/etc/hostapd/accept
    auth_algs=1" | sudo tee /etc/ap-hotspot.conf >/dev/null;
    echo "Type the MAC address of your 3DS:";
    read -e mymac;
    echo "$mymac" | sudo tee /etc/hostapd/accept >/dev/null;
    echo "";
    echo "Finished installing dependencies.";
    echo "We need to reboot in order to make hostapd and ap-hotspot work well.";
    echo "Please end the script (Ctrl+C) if you can't reboot in 30 seconds.";
    sleep 30;
    sudo reboot;
}

while [ 0 ]
do
    for i in "${macs[@]}"
    do
        sudo ap-hotspot stop
        sudo killall hostapd
        echo "Using $i MAC address for the hotspot"
        sudo ifconfig wlan0 down hw ether "$i" up
        sleep 5
        sudo ap-hotspot start
        echo "Waiting $(($waittime/60)) minutes..."
        echo ""
        sleep $waittime
    done
    echo ""
    echo "Starting the cycle again"
    echo ""
done

