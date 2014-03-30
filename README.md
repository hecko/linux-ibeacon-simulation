linux-ibeacon-simulation
========================

Simulates iBeacon using USB BLE dongle and BlueZ

**Tested with this working config:**
* BlueZ 5.17 (manual upgrade)
* Linux (3.10.34+ / Bluetooth: Core ver 2.16 / on Raspbian / Raspberry PI)
* BLE dongle marked "plugable"
* iPhone 5S, iOS7.1
* Locate IB app (needs UUID added from the script!)

###### Installing / upgrading BlueZ on Linux ######
https://www.kernel.org/pub/linux/bluetooth/
```
./configure --disable-systemd
make all
make install
```
