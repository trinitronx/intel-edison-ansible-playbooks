OSX Yosemite + iPhone remote "in the field" networking setup
=============================================================

Ever needed a way to get a small LAN working in a remote area?  This guide is for you.
The goal of this guide is to show how to set up an "in the field" networking setup using the following hardware:

 - Apple Macbook Pro Retina 13 inch running OSX Yosemite (10.10.5)
 - Apple iPhone 5 running iOS 9.3.2
 - 2x [Intel Edison](https://en.wikipedia.org/wiki/Intel_Edison) chips
 - 1x [Arduino Breakout Board](https://en.wikipedia.org/wiki/Intel_Edison#Arduino_board) (Optional, but makes the WiFi AP setup easier due to included `PWR` button)

Network Diagram
===============

![iPhone remote in-the-field Network Diagram](https://www.lucidchart.com/publicSegments/view/c9b0b5e0-2b19-41ac-9381-d58cd837f044/image.png)

Steps:
======

 1. Setup WAN connection: Tether iPhone to Macbook for WAN access
 2. Setup WiFi AP: Configure 1 Intel Edison (recommended: on Arduino board) as WiFi AP
 3. Networking Setup: Set up packet forwarding, NAT rules & routing to give WAN access to the WiFi LAN

Setup WAN Connection
--------------------

The first step will be to set up an external connection to the internet using the iPhone's access to the cellular network.  

To start, plug your iPhone into the Macbook Pro with a USB to Lightning adapter cable.

Next, go to `Settings` `->` `Personal Hotspot` and flip the slider switch to the "`ON`" position to turn the `Personal Hotspot` feature on.  If you have configured your Macbook to automatically open iTunes & Photos apps when plugging in an iPhone, you should see that both apps re-opened and recognized that the iPhone tethering connection was just reset.

Finally, to verify that the iPhone tethering connection is working, open `System Preferences` `->` `Network` and you should see a new network adapter named "`iPhone USB`" is in `Connected` state.  Note the IP address shown in the rightmost portion of the dialog window (e.g.: "iPhone USB is currently active and has the IP address 172.20.10.12.")

To prepare for the final networking steps, open a `Terminal` window and run: `ifconfig`.  Search the list of network interfaces for the same IP address shown for the "`iPhone USB`" adapter.  You should see a stanza like:

    en6: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
    ether a2:ed:c0:de:ca:fe
    inet6 fe80::abcd:efab:fcb1:d832%en6 prefixlen 64 scopeid 0xb
    inet 172.20.10.12 netmask 0xfffffff0 broadcast 172.20.10.25
    nd6 options=1<PERFORMNUD>
    media: 100baseTX <full-duplex>
    status: active

Take note of the interface name for the "**Networking Setup**" steps below (e.g.: **`en6`** in the example above)

Setup WiFi AP
=============

Intel's documentation for configuring an Edison for Access Point Mode was very hard to find.  There is, however a cached version on archive.org: [Configure Edison (Access Point Mode)][1] which gives some very helpful tips.  Below is a copied version of that guide for future googlers:

## Mirrored Version of Intel Edison [DOC-23137][2]: "Configure Edison (Access Point Mode)"

### Step 1 – Connecting Edison

 1. Connect two micro USB cables into the Arduino board, and the other ends into your computer.  \***note - make sure the micro switch in between the USB ports on the Arduino board is switched towards the micro USB ports**\*

 ![Image of Intel Edison Arduino Breakout Board: On the right, top to bottom: DC female jack, large USB-A port, micro switch (in down position), small micro USB ports.  The micro switch is between the larger USB-A female port and the two smaller micro USB ports](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238755/1600-869/IMG_20140906_142611~2.jpg)

### Step 2 – Enable AP mode and connect

 1. Press and hold the `PWR` (power) button on the Arduino expansion board for **2 to 3 seconds**, then release the button. **(Holding the button down for more than 7 seconds will power off the board.)**<br/><br/>![Image of Intel Edison Arduino Breakout Board: A finger presses the PWR button.  With ports facing the right, buttons are on top left.  The buttons from left to right are: RM, FW, PWR, SHLD.](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238749/1600-846/IMG_20140906_195830~2.jpg)
 2. The LED should start blinking and you should see a new available wireless network named `EDISON-xx-xx`
 3. Connect to this network.  \***note - this will disconnect your computer from the internet**\*
 4. You will be prompted for a password.  This password is the **serial number (S/N)** printed on the label on the box

![Image of Intel Edison package.  On bottom of box, a sticker with Serial Number is labeled "S/N"](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238756/1600-667/IMG_20140906_202144~2.jpg)

### Step 3 – Configure Edison

 1. Open a web browser and go to "http://edison.local".  \***note - if you have already changed the name and password of you Edison, then replace "`edison`" in the URL with the name you have chosen.**<br/><br/>![Image of Google Chrome Web Browser: Page opened is "edison.local".  Edison One-time Setup page is shown.](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238750/1560-900/Screen+Shot+2014-09-06+at+8.18.45+PM.png)
 2. Enter a new password and name for Edison.  In this example we will call Edison "`myedison`"<br/><br/>![Image of Edison One-time Setup Page: Set device password & Change Device Name fields are shown.  Name is set to "myedison".](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238751/1600-716/Screen+Shot+2014-09-06+at+8.32.01+PM.png)
 3. Enter the name and pasword of your WiFi network.  If you do not know the network protocol of your network, try "`WPA-Personal`" first.<br/><br/>![Image of Edison One-time Setup Page: Connect to A WiFi Network fields shown.  Network name is set to "kafka", Network Protocol is set to "WPA-Personal or WPA2-Personal". Password is set but blocked out.](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238752/1600-311/Screen+Shot+2014-09-06+at+8.32.17+PM.png)
 4. Click "Submit"
 5. You will see this screen.  Please connect to your WiFi network now, and after **one** minute visit "http://myedison.local".  If you have chosen a different name for your Edison then replace "`myedison`" with your name.<br/><br/>![Image of Leaving One-time Setup Page: Text is: "Please wait while the device connects to 'kafka'. After about a minute, connect this machine to 'kafka' and visit http://myedison.local in your browser. "](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238753/1600-635/Screen+Shot+2014-09-06+at+8.32.37+PM.png)
 6. Visiting the "myedison.local" page will verify if you have successfully configured and connected Edison to WiFi.<br/><br/>![Image of Intel Edison Device Information Page: Hostname is shown as "myedison", IP Address is shown.](https://web.archive.org/web/20141213055724im_/https://communities.intel.com/servlet/JiveServlet/downloadImage/102-23137-8-238754/1600-446/Screen+Shot+2014-09-06+at+8.36.06+PM.png)

**Congratulations, you have successfully configured and connected your Intel® Edison development board to WiFi!**

## Intel Edison AP Mode Manual Steps & Verification

If you were able to follow the above guide, you should now have an Intel Edison set up in Access Point (AP) Mode.  You should also have connected your Macbook's WiFi adapter to the Intel Edison AP's wireless network by finding the SSID with the same name you gave your Edison.  If for some reason this didn't work, you're still having trouble getting it into AP mode, or if you don't have a breakout board with the `PWR` button, then the following steps should help to get it set up manually.

First, I must mention the **extremely helpful** and official "[Intel Edison Wi-Fi Guide][3]".  This `.pdf` document goes into much better detail about all the internal services & software architecture, how to get connected, and setting up the Edison in various Wi-Fi modes.  In our setup, we will be using the "Access Point Setup", which is detailed in Section 5 of that PDF Guide.

 1. Either SSH or connect a serial console to the Edison over the micro USB port.
 2. Open the `/etc/hostapd/hostapd.conf` file with an editor.  The basic and ubiquitous `vi` is already installed, so that is recommended if you know how to use it.
 3. Ensure that your configuration has *at least* lines like the following (Full [example configuration may be found here][4] or an example is also attached below):
        interface=wlan0
        driver=nl80211
        ssid=<YOUR_EDISON_SSID_NAME_HERE>
        hw_mode=g
        channel=1
        wpa=2
        wpa_passphrase=<YOUR_EDISON_WIFI_WPA_PASSPHRASE_HERE>
        wpa_key_mgmt=WPA-PSK
        wpa_pairwise=TKIP CCMP
        rsn_pairwise=CCMP
 4. Replace the tokens "`<YOUR_EDISON_SSID_NAME_HERE>`", and "`<YOUR_EDISON_WIFI_WPA_PASSPHRASE_HERE>`" with your SSID and WPA2 Passphrase of your choice.<br/>(Defaults: `SSID` = hostname of Edison, `wpa_passphrase` = S/N of Edison)
 5. Stop `wpa_supplicant` first: `systemctl stop wpa_supplicant`
 6. Start `hostapd`: `systemctl restart hostapd`

You should now see that `hostapd` is running with `systemctl status hostapd`.

    root@myedison:~# systemctl status hostapd
    ● hostapd.service - Hostap daemon service
       Loaded: loaded (/lib/systemd/system/hostapd.service; enabled)
       Active: active (running) since Mon 2016-05-23 00:40:40 UTC; 2h 38min ago
      Process: 223 ExecStartPre=/sbin/modprobe bcm4334x op_mode=2 (code=exited, status=0/SUCCESS)
      Process: 184 ExecStartPre=/sbin/modprobe -r bcm4334x (code=exited, status=0/SUCCESS)
     Main PID: 254 (hostapd)
       CGroup: /system.slice/hostapd.service
               └─254 /usr/sbin/hostapd /etc/hostapd/hostapd.conf

    May 23 02:02:25 myedison hostapd[474]: Configuration file: /etc/hostapd/hostapd.conf
    May 23 02:02:25 myedison hostapd[474]: Using interface wlan0 with hwaddr 90:b6:00:ff:c0:de and ssid "myedison"
    May 23 02:02:25 myedison hostapd[474]: random: Only 18/20 bytes of strong random data available from /dev/random
    May 23 02:02:25 myedison hostapd[474]: random: Not enough entropy pool available for secure operations
    May 23 02:02:25 myedison hostapd[474]: WPA: Not enough entropy in random pool for secure operations - update keys later when the first station connects
    May 23 02:02:25 myedison hostapd[474]: wlan0: interface state UNINITIALIZED->ENABLED
    May 23 02:02:25 myedison hostapd[474]: wlan0: AP-ENABLED
    May 23 02:02:25 myedison hostapd[474]: wlan0: STA 78:4b:87:a0:59:48 IEEE 802.11: associated

Open your Macbook's `System Preferences` `->` `Network` pane, turn on Wi-Fi, and select your Intel Edison's SSID to connect.  If you did not set a WPA2 Passphrase earlier, the default is usually the Edison's serial number.  You may find your Edison's serial number by running: `cat /factory/serial_number`. It should be a 17 character string, for example: "`FFDDCCA1200TT1234`".

Congratulations! You should now be connected to the Edison's Wi-Fi AP!


### Example `/etc/hostapd/hostapd.conf` config:

    interface=wlan0
    driver=nl80211
    logger_syslog=-1
    logger_syslog_level=2
    logger_stdout=-1
    logger_stdout_level=2
    ctrl_interface=/var/run/hostapd
    ctrl_interface_group=0
    ssid=<YOUR_EDISON_SSID_NAME_HERE>
    hw_mode=g
    channel=1
    beacon_int=100
    dtim_period=2
    max_num_sta=255
    rts_threshold=2347
    fragm_threshold=2346
    macaddr_acl=0
    auth_algs=1
    ignore_broadcast_ssid=0
    wmm_enabled=1
    wmm_ac_bk_cwmin=4
    wmm_ac_bk_cwmax=10
    wmm_ac_bk_aifs=7
    wmm_ac_bk_txop_limit=0
    wmm_ac_bk_acm=0
    wmm_ac_be_aifs=3
    wmm_ac_be_cwmin=4
    wmm_ac_be_cwmax=10
    wmm_ac_be_txop_limit=0
    wmm_ac_be_acm=0
    wmm_ac_vi_aifs=2
    wmm_ac_vi_cwmin=3
    wmm_ac_vi_cwmax=4
    wmm_ac_vi_txop_limit=94
    wmm_ac_vi_acm=0
    wmm_ac_vo_aifs=2
    wmm_ac_vo_cwmin=2
    wmm_ac_vo_cwmax=3
    wmm_ac_vo_txop_limit=47
    wmm_ac_vo_acm=0
    ieee80211n=1
    eapol_key_index_workaround=0
    eap_server=0
    own_ip_addr=127.0.0.1
    wpa=2
    wpa_passphrase=<YOUR_EDISON_WIFI_WPA_PASSPHRASE_HERE>
    wpa_key_mgmt=WPA-PSK
    wpa_pairwise=TKIP CCMP
    rsn_pairwise=CCMP


Networking Setup:
=================

By now you should have your Macbook tethered & connected to your iPhone via USB, and also connected to one of your Intel Edison's Wi-Fi AP.  We now must enable packet forwarding, some routing, and DNS configuration to get connections out from the Intel Edison AP-hosted LAN to the Internet (WAN).  First step is to enable packet forwarding.  There are guides for both [OSX Yosemite pf & NAT Setup][5], and [Linux pf & NAT Setup][6] online.  We will however only be doing NAT on the Macbook, **NOT** the Edison.

 1. Set up packet forwarding **on Macbook** (OSX Yosemite):<br/><br/>
        sudo sysctl -w net.inet.ip.forwarding=1
        sudo sysctl -w net.inet.ip.fw.enable=1

 2. Set up NAT rules **on Macbook**:
   - Here is where you need the interface names for the Macbook's `Wi-Fi` and `iPhone USB` network adapters.
   - Syntax is: `nat on $ext_if from $localnet to any -> ($ext_if)`
   - Where:
      - `$ext_if = <iPhone USB interface>`
      - `$localnet = <WiFi interface>:network`
   - **For Example:** Given `iPhone USB = en6`, `WiFi = en0`<br/>Write the following to a file named `nat-rules`<br/><br/>
        nat on en6 from en0:network to any -> (en6)

 3. Turn on NAT **on Macbook** (OSX Yosemite) via `pfctl`:<br/><br/>
        sudo pfctl -d #disables pfctl
        sudo pfctl -F all #flushes all pfctl rule
        sudo pfctl -f /Path/to/file/nat-rules -E #start pfctl & load rules from nat-rules file

 4. Set up default route **on Edison AP**:
   - This will route from Intel Edison AP (to) -> Macbook's Wi-Fi interface.
   - Find the Macbook Wi-Fi IP using `ifconfig`. (e.g.: listed as "`inet 192.168.xx.xx`" under `en0`)<br/><br/>
        ip route add default via <YOUR_MACBOOK_WIFI_IP_HERE>

 5. Set up packet forwarding **on Edison AP**:<br/><br/>
        sysctl -w net.ipv4.ip_forward=1

 6. Set up DNS in `/etc/resolv.conf` **on Intel Edison AP**:
   - Edit your `/etc/resolv.conf` and change `nameserver` lines to:<br/><br/>
        nameserver 8.8.8.8
        nameserver 4.2.2.2

 6. Set up DNS via DHCP **on Intel Edison AP**:
   - Edit the `/etc/hostapd/udhcpd-for-hostapd.conf` file
   - Change the line `#opt dns` to contain DNS servers of your choosing.
   - For Example:<br/><br/>
        opt dns 8.8.8.8 4.2.2.2  # Google DNS servers.
        # Alternatives: Level3 (209.244.0.3 209.244.0.4), OpenDNS (208.67.222.222 208.67.220.220), Verisign (64.6.64.6 64.6.65.6)
        # Full list: http://pcsupport.about.com/od/tipstricks/a/free-public-dns-servers.htm
        # If you can't remember this, or are too remote to have this guide handy, tweet @OpenDNS or goto http://208.69.38.205 for help setting up.

 7. Restart `udhcpd` **on Intel Edison AP**:<br/><br/>
        systemctl restart udhcpd-for-hostapd.service hostapd.service

 8. Your Wi-Fi Clients should now have the DNS servers you set automatically added to their network configuration.
 9. **On any other** Intel Edison boards that you wish to set up as Wi-Fi Clients:
   - Run `configure_edison --wifi`
   - Wait for Wi-Fi scan to complete
   - Select your Intel Edison AP's SSID
   - Enter the WPA Passphrase you chose above
   - Set up static route, set default gateway to Macbook: `ip route add default via <YOUR_MACBOOK_WIFI_IP_HERE>`
   - Test outbound DNS via: `nslookup google.com;  ping google.com;`
   - Test outbound routing via: `ping 8.8.8.8`

**Congratulations!**

If you have reached this point, you should have a working portable mini-LAN that should work anywhere that has good enough Cell data coverage and will last as long as your batteries hold out.  Plug in to a generator for extra credit ;-)


[1]: https://web.archive.org/web/20141213055724/https://communities.intel.com/docs/DOC-23137
[2]: https://communities.intel.com/docs/DOC-23137
[3]: download.intel.com/support/edison/sb/edison_wifi_331438001.pdf
[4]: http://w1.fi/cgit/hostap/plain/hostapd/hostapd.conf
[5]: https://linux-master.ro/operating-systems/nat-mac-osx-yosemite/
[6]: http://askubuntu.com/questions/227369/how-can-i-set-my-linux-box-as-a-router-to-forward-ip-packets
