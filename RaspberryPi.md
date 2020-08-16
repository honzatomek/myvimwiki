:Raspbery:RaspberryPi:RPi:RasPi:

# Contents

- [SSH](#SSH)
    - [key conversion](#SSH#key conversion)
        - [to OpenSSH](#SSH#key conversion#to OpenSSH)
        - [from OpenSSH](#SSH#key conversion#from OpenSSH)
        - [export to file](#SSH#key conversion#export to file)
        - [add the key to authorized_keys](#SSH#key conversion#add the key to authorized_keys)
        - [automation by script](#SSH#key conversion#automation by script)
    - [ssh setup](#SSH#ssh setup)
    - [Xming](#SSH#Xming)
        - [setup](#SSH#Xming#setup)
        - [reset](#SSH#Xming#reset)
    - [tunnelling](#SSH#tunnelling)
        - [setup](#SSH#tunnelling#setup)
        - [initiate ssh tunnel](#SSH#tunnelling#initiate ssh tunnel)
        - [via systemd service:](#SSH#tunnelling#via systemd service:)
        - [specify other ports:](#SSH#tunnelling#specify other ports:)
        - [use the tunnel](#SSH#tunnelling#use the tunnel)
        - [copy files through the tunnel](#SSH#tunnelling#copy files through the tunnel)
- [WLAN](#WLAN)
    - [network devices](#WLAN#network devices)
        - [show](#WLAN#network devices#show)
        - [info](#WLAN#network devices#info)
        - [naming rules](#WLAN#network devices#naming rules)
        - [persistent name](#WLAN#network devices#persistent name)
    - [WLAN Hotspot](#WLAN#WLAN Hotspot)
        - [Raspberry Pi3 B+](#WLAN#WLAN Hotspot#Raspberry Pi3 B+)
            - [packages](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#packages)
            - [Network interface configuration](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#Network interface configuration)
            - [hostapd configuration](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#hostapd configuration)
            - [dnsmasq configuration](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#dnsmasq configuration)
            - [IPv4 Forwarding configuration](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#IPv4 Forwarding configuration)
            - [Finish](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#Finish)
            - [Notes](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#Notes)
            - [script for wlan0](#WLAN#WLAN Hotspot#Raspberry Pi3 B+#script for wlan0)
        - [Raspberry Pi 4](#WLAN#WLAN Hotspot#Raspberry Pi 4)
            - [wlan1](#WLAN#WLAN Hotspot#Raspberry Pi 4#wlan1)
- [swap size](#swap size)
- [APT](#APT)
    - [search for package](#APT#search for package)
    - [show package info](#APT#show package info)
- [VLC](#VLC)
    - [nvlc](#VLC#nvlc)

# SSH
## key conversion
### to OpenSSH
```bash
ssh-keygen -i -f FILE_IN.ppk
```
    output of `man ssh-keygen`:

     -i      This option will read an unencrypted private (or public) key file
	     in the format specified by the -m option and print an OpenSSH
	     compatible private (or public) key to stdout.  This option allows
	     importing keys from other software, including several commercial
	     SSH implementations. The default import format is “RFC4716”.

     -f filename
             Specifies the filename of the key file.

     -m key_format
	     Specify a key format for the -i (import) or -e (export) conversion
	     options.  The supported key formats are: “RFC4716” (RFC 4716/SSH2
	     public or private key), “PKCS8” (PEM PKCS8 public key) or “PEM”
	     (PEM public key).  The default conversion format is “RFC4716”.
	     Setting a format of “PEM” when generating or updating a supported
	     private key type will cause the key to be stored in the legacy PEM
	     private key format.

### from OpenSSH
```bash
ssh-keygen -e -f FILE_IN.ppk
```
    output of `man ssh-keygen`:

     -e      This option will read a private or public OpenSSH key file and
	     print to stdout the key in one of the formats specified by the -m
	     option. The default export format is “RFC4716”.  This option
	     allows exporting OpenSSH keys for use by other programs, including
	     several commercial SSH implementations.

### export to file
```bash
ssh-keygen -i -f FILE_IN.ppk > FILE_OUT.ppk
```

### add the key to authorized_keys
```bash
ssh-keygen -i -f FILE_IN.ppk >> "${HOME}/.ssh/authorized_keys"
```

### automation by script
```bash
#!/bin/bash

HELP='Script to turn ssh.ppk key from Puttygen to linux format
Use: ./ssh_key_to_linux.sh FILE_IN FILE_OUT

FILE_IN   *.ppk  file generated from Puttygen
FILE_OUT  *.ppk  for the ssh key in new format

if FILE_OUT is not specified then the key is appended to ~/.ssh/authorized_keys
if FILE_OUT exists, the key is appened to it.'

FILE_IN=""
FILE_OUT=""
PARAMS=""

while (( "$#" )); do
  case "$1" in
    # parsing optional arguments
    -h|--help) HLP=true; shift ;;
    # end argument parsing
    -|--) shift; break ;;
    # unsupported flags
    -*|--*) echo "[-] Error: Unsupported flag  $1" >&2; exit 1 ;;
    # preserve positional arguments
    *)
      PARAMS="$PARAMS $1"
      if [[ "$FILE_IN" == "" ]]; then
	FILE_IN="$1"
	shift
      else
        FILE_OUT="$1"
        break
      fi
  esac
done

if [[ "$FILE_IN" == "" ]]; then
  echo "[-] Error, the FILE_IN was not supplied."
  echo "$HELP"
  exit 1
fi

eval set -- "$PARAMS"

if [[ "$FILE_OUT" == "" ]]; then
  FILE_OUT="$HOME/.ssh/authorized_keys"
fi

# echo "[+] Whole command:  ssh_key_to_linux.sh $PARAMS"
# echo "[+] Used command:   ssh_key_to_linux.sh $FILE_IN $FILE_OUT"
echo "[+] Command to be used:"
echo "      ssh-keygen -i -f $FILE_IN >> $FILE_OUT"
echo -e "[+] Preview of the output:\n"
output=$(ssh-keygen -i -f "$FILE_IN")
echo -e "$output\n"

if [[ "$output" == "" ]]; then
  echo "[-] Input key in a wrong format, must be a public key."
  echo -e "    Trying ssh-keygen export:\n"
  output=$(ssh-keygen -e -f "$FILE_IN")
  if [[ "$output" == "" ]]; then
    echo -e "\n[-] The key supplied in $FILE_IN is wrong."
  else
     echo "$output"
  fi
  echo "    Exiting.."
  exit 1
fi

while true; do
read -p "[+] Do you want to append this key to $FILE_OUT? [y/n] " choice
  case "$choice" in
    [yY]|[yY][eE][sS])
      echo "    yes"
      ssh-keygen -i -f "$FILE_IN" >> "$FILE_OUT"
      echo "[+] The key was successfully exported to: $FILE_OUT"
      exit 1;;
    [nN]|[nN][oO]) echo "[-] The script was ended by user input -> exiting.."; exit 1 ;;
    *) echo "[-] Please answer yes or no.";;
  esac
done
```

## ssh setup
https://stackoverflow.com/questions/16212816/setting-up-openssh-for-windows-using-public-key-authentication/50502015#50502015

Following are setup steps for OpenSSH shipped with Windows 10 v.1803 (April
2018 update. See comments to this post, it might not work with 1809).

Server setup (*elevated powershell*):

Install OpenSSH server:
`Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0.`

Start agent and sshd services:
`Start-Service ssh-agent; Start-Service sshd`
(this will generate host keys and default configuration automatically in
*$env:ProgramData\ssh*).

[Optional] Install OpenSSHUtils powershell module:
`Install-Module -Force OpenSSHUtils`

Client setup (*non-elevated powershell*):

Generate user key:
`cd $env:USERPROFILE\.ssh; ssh-keygen.exe`
follow prompts, agree to the default suggested file location. This will create
2 files: *id_rsa* and *id_rsa.pub*;

[Optional] add key to authentication agent, so you don't have to enter password
each time you use it:
`ssh-add .\id_rsa`
(or whatever file was generated);

Server setup continued (non-elevated powershell):

Log in as a user, for which public key auth to be used
`cd $env:USERPROFILE; mkdir .ssh; cd .ssh; New-Item authorized_keys;`

Paste the contents of the *id_rsa.pub file* from the client to the
*.ssh\authorized_keys* file from the previous step. Setup permissions properly
(important!!!):

Run:
`start .`

to open explorer with the current folder (*$env:USERPROFILE\.ssh*); Right click
authorized_keys, go to *Properties -> Security -> Advanced*. Click "Disable
inheritance"; Choose "Convert inherited permissions into explicit permissions
on this object" when prompted; (really, really important) Remove all
permissions on file except for the SYSTEM and yourself. There must be exactly
two permission entries on the file. Some guides suggest running the

`Repair-AuthorizedKeyPermission $env:USERPROFILE\.ssh\authorized_keys`

this will try to add the sshd user to the permission list and it will break the
authentication, so, don't do that, or at least do not agree on adding the sshd
user). Both SYSTEM and yourself should have full control over the file.

Client:
Run

`ssh <serverusername>@<serverhostname>`

It should work at this point. Tried that with Windows 10 as server and both
itself and a Debian Linux as a client.

EDIT: (see comment section below) Current windows build require to also comment
out the following in
```powershell
PS C:\ProgramData\ssh> bash -c 'vim sshd_config'

# Match Group administrators
#       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

## Xming
### setup
```bash
#!/bin/bash

if [ -f "/etc/ssh/ssh_config" ]; then
  echo "[+] Editing /etc/ssh/ssh_config"
  sudo cp /etc/ssh/ssh_config /etc/ssh/ssh_config.orig
  sudo sed -i -e 's/#   ForwardX11 yes/ForwardX11 yes/g' /etc/ssh/ssh_config
  sudo sed -i -e 's/#   ForwardX11 no/ForwardX11 yes/g' /etc/ssh/ssh_config
  sudo sed -i -e 's/#   ForwardX11Trusted yes/ForwardX11Trusted yes/g' /etc/ssh/ssh_config
  sudo sed -i -e 's/#   ForwardX11Trusted no/ForwardX11Trusted yes/g' /etc/ssh/ssh_config
  sudo sed -i -e 's/ForwardX11Trusted no/ForwardX11Trusted yes/g' /etc/ssh/ssh_config
fi

if [ -f "/etc/ssh/sshd_config" ]; then
  echo "[+] Editing /etc/ssh/sshd_config"
  sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
  sudo sed -i -e 's/X11Forwarding no/X11Forwarding yes/g' /etc/ssh/sshd_config
  sudo sed -i -e 's/#X11Forwarding yes/X11Frowarding yes/g' /etc/ssh/sshd_config
  sudo sed -i -e 's/#X11DisplayOffset 10/X11DisplayOffset 10/g' /etc/ssh/sshd_config
fi

/etc/init.d/ssh restart
```

### reset
```bash
#!/bin/bash

sudo cp /etc/ssh/ssh_config.orig /etc/ssh/ssh_config
sudo cp /etc/ssh/sshd_config.orig /etc/ssh/sshd_config

/etc/init.d/ssh restart
```

## tunnelling
from: https://sshhub.de/advanced/

### setup
first register at `www.sshhub.de`:
```bash
ssh info@sshhub.de register
```
input `[USERNAME]` there

add __ssh__ __public__ __key__ there for authentication:
```bash
ssh [USERNAME]@sshhub.de pubkey add "$(cat ~/.ssh/id_rsa.pub)"
```

list all pubkeys:
```bash
ssh [USERNAME]@sshhub.de pubkey ls
```

remove a public key:
```bash
cat ~/.ssh/id_rsa.pub | ssh [USERNAME]@sshhub.de pubkey rm
```

add a private key to __ssh authentication agent__:
- in `termux` add the following lines to `.bashrc`
- in standard linux put it to `/etc/rc.local`
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

### initiate ssh tunnel
initiate __ssh tunnel__ from raspberry (either in rc.local or as a cron job or as a service):
bash loop:
```bash
while true; do
    ssh [USERNAME]@sshhub.de -R [COMPUTERNAME]:22:localhost:22 -N -o ServerAliveInterval=10
    sleep 5
done
```

or without `ssh key` added to `ssh-agent`:
```bash
while true; do
    ssh -i [PATH_TO_PRVATE_KEY] [USERNAME]@sshhub.de -R [COMPUTERNAME]:22:localhost:22 -N -o ServerAliveInterval=10
    sleep 5
done
```

a specific port can be used (ports 1 - 1024 are reserved for the system, or use 22 - default port for SSH);
```bash
while true; do
    ssh -i [PATH_TO_PRVATE_KEY] [USERNAME]@sshhub.de -R [COMPUTERNAME]:22:localhost:1234 -N -o ServerAliveInterval=10
    sleep 5
done
```
temporary ports: 1025 - 32768

### via systemd service:
create a systemd unit file (/etc/systemd/system/sshhub.service)
```systemd
[Unit]
Description=Setup a secure tunnel to sshhub
After=network.target
User=[your username]
Group=[your group]

[Service]
ExecStart=/usr/bin/ssh [USERNAME]@sshhub.de -R [COMPUTERNAME]:22:localhost:22 -N -o ServerAliveInterval=10

# Restart every >2 seconds to avoid StartLimitInterval failure
RestartSec=5
Restart=always

[Install]
WantedBy=multi-user.target
```

Start it and test if it worked:
```bash
systemctl start sshhub.service
systemctl status sshhub.service
```

Start sshhub automatically on startup:
```bash
systemctl enable sshhub.service
```
---------------------------------------------------------------------------------------------------
__do not forget to ssh to sshhub.de at least once as root to add the sshhub.de host to known hosts!!!__
---------------------------------------------------------------------------------------------------

### specify other ports:
```bash
# Share local port [R_PORT] under the name [COMPUTERNAME]:[PORT].
server> ssh [USERNAME]@sshhub.de -R [COMPUTERNAME]:[R_PORT]:localhost:[PORT]
# Forward local port [L_PORT] to the port shared above.
client> ssh -J [USERNAME]@sshhub.de [L_PORT]:[COMPUTERNAME]:[PORT]
```
only `[COMPUTERNAME]` and `[PORT]` variables can be specified at the moment

### use the tunnel
```bash
ssh -l [USER] -J [USERNAME]@sshhub.de [COMPUTERNAME] -p [PORT]
```

### copy files through the tunnel
From: https://www.urbaninsight.com/article/running-scp-through-ssh-tunnel
first setup the tunnel from the client side (use other than ssh port `22`)
```bash
ssh -i ~/.ssh/xiaomi -L 1234:raspberrypi4:22 honzatomek@sshhub.de
```

adding `cat -` will keep the tunnel running:
```bash
ssh -i ~/.ssh/xiaomi -L 1234:raspberrypi4:22 honzatomek@sshhub.de
```

this will set that commands sent to `127.0.0.1` (localhost) at port `1234` will be
sent to the remote machine behind the tunnel

then in a new terminal you can use the `scp` command:
```bash
scp -P 1234 pi@127.0.0.1:/path-to-file /local-path-to-copy-to
```
the `-P` option specifies the port
`scp` commandd:
```bash
scp -P [PORT] [USER]@[ADDRESS]:[REMOTE PATH] [LOCAL PATH]
```

or open `mc` in new terminal and use __shell link__ (`<F9>` `r` `h`):
```
pi@127.0.0.1:1234
```

and you're good to go!


# WLAN
## network devices
### show
```bash
ifconfig
```

### info
show info on network device:
```bash
udevadm info /sys/class/net/wlan1
```

show full info on network device:
```bash
udevadm info /sys/class/net/wlan1 --attribute-walk
```

### naming rules
test rules used for naming the device
```bash
sudo udevadm test /sys/class/net/wlan1
```

location of rules for naming the devices (in hierarchic order, first wins):
```bash
/etc/udev/rules.d/
/lib/udev/rules.d/
```

### persistent name
naming rule example for _/etc/udev/rules.d/70-persistent-net.rules_
keywords can be selected based upon udevadm info `/sys/class/net/wlan1 --attribute-walk` output
```bash
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="b8:27:eb:fd:28:27", ATTR{type}=="1", KERNEL=="wlan*", NAME="wlan0"
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:ad:24:42:ce:6e", ATTR{type}=="1", KERNEL=="wlan*", NAME="wlan1"
```

for the naming rules to work, a following symlink has to be created:
```bash
ln -s /lib/udev/rules.d/80-net-setup-link.rules /etc/udev/rules.d/80-net-setup-link.rules
```

## WLAN Hotspot
### Raspberry Pi3 B+
####  packages
	hostapd – This package allows for creation of WiFi hotspot
	dnsmasq – A combination of DHCP and DNS server

####  Network interface configuration
We have to set up a static IP address of *wlan0* device.

First we have to edit *dhcpd* config file to ignore *wlan0* device.

```bash
sudo nano /etc/dhcpcd.conf
```

Insert on the last row:

```bash
denyinterfaces wlan0
```

Then we have to set up our *static IP address*:

```bash
sudo nano /etc/network/interfaces
```

Where we edit *wlan0* section to look like this:

```bash
allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    network 192.168.1.0
    broadcast 192.168.1.255
#   wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

As a last step we restart *dhcpcd*:

```bash
sudo service dhcpcd restart
```

And reread *wlan0* config:

```bash
sudo ifdown wlan0; sudo ifup wlan0
```

:hostapd:
####  hostapd configuration
Next we have to set up *hostapd*. Let us therefore creat a new config file:

```bash
sudo nano /etc/hostapd/hostapd.conf
```

and insert the following content to be then modified based on our needs
(*ssid* = name of wifi network, *wpa_passphrase* = wifi network password).
If you use a <space>, enclose the whole string in "".

```bash
# This is the name of the WiFi interface we configured above
interface=wlan0
# Use the nl80211 driver with the brcmfmac driver
driver=nl80211
# This is the name of the network
ssid=SSID_VASI_WIFI
# Use the 2.4GHz band
hw_mode=g
# Use channel 6
channel=6
# Enable 802.11n
ieee80211n=1
# Enable WMM
wmm_enabled=1
# Enable 40MHz channels with 20ns guard interval
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
# Accept all MAC addresses
macaddr_acl=0
# Use WPA authentication
auth_algs=1
# Require clients to know the network name
ignore_broadcast_ssid=0
# Use WPA2
wpa=2
# Use a pre-shared key
wpa_key_mgmt=WPA-PSK
# The network passphrase
wpa_passphrase=HESLO_DO_VASI_WIFI
# Use AES, instead of TKIP
rsn_pairwise=CCMP
```

After saving the config file we can test if everything works as it should
using command:

```bash
sudo /usr/sbin/hostapd /etc/hostapd/hostapd.conf
```

Within several seconds you should be able to see your WiFi network. If you
try to connect to it your trial will not be successful as no IP address will
be assigned to you. That is covered in the following steps. Let us end the
running WiFi AP process with a combination of <c-c>.

There is one last thing to do in *hostapd* configuration. It is for the WiFi
to start after booting. Let us open this config file:

```bash
sudo nano /etc/default/hostapd
```

Find this commented line:

```bash
#DAEMON_CONF=""
```

and replace the line with this:

```bash
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

This will make sure that WiFi AP will start after the system startup.

:dnsmasq:
####  dnsmasq configuration
The *dnsmasq* configuration file contains a huge amount of (for us) unneeded
information. Therefore we rename the original file and create our own:

```bash
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo nano /etc/dnsmasq.conf
```

Insert this content:

```bash
interface=wlan0                           # Use interface wlan0
listen-address=192.168.1.1                # Explicitly specify the address to listen on
bind-interfaces                           # Bind to the interface to make sure we aren't sending things elsewhere
server=8.8.8.8                            # Forward DNS requests to Google DNS
domain-needed                             # Don't forward short names
bogus-priv                                # Never forward addresses in the non-routed address spaces.
dhcp-range=192.168.1.10,192.168.1.100,12h # Assign IP addresses between 192.168.1.10 and 192.168.1.100 with a 12 hour lease time
```

:IPv4_Forwarding:
####  IPv4 Forwarding configuration
At this moment we have a functioning *WiFi hotspot* to which client devices
can connect and which are allocated an IP address. The only thing left is
to add internet connection. In our case it will be from *Ethernet* (_eth0_).

First *IPv4 Forwarding* must be allowed. Open _sysctl.conf_

```bash
sudo nano /etc/sysctl.conf
```

and uncomment (delete #) line containing:

```bash
net.ipv4.ip_forward=1
```

This setting will apply after the system reboot so either reboot system

```bash
sudo reboot -h now
```

or use following command:

```bash
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
```

Now only the *iptables* setup is left. We have to set up *NAT* between _wlan0_
and _eth0_ (WiFi and Ethernet). This will be simply done using these commands:

```bash
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
```

This setting is *deleted* after each system restart. To override this we can
save the current configuration:

```bash
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
```

To make sure the _/etc/iptables.ipv4.nat_ is read after system start we edit
the *rc.local* file:

```bash
sudo nano /etc/rc.local
```

and add the following line before the `exit 0` line:

```bash
iptables-restore < /etc/iptables.ipv4.nat
```

####  Finish
At this moment we're finished. Everything should work after *restarting* the
system. If you don't want to restart, it is enough to run these two services:

```bash
sudo service hostapd start
sudo service dnsmasq start
```

####  Notes
If something is not working:

*WiFi Hotspot* -- look for an error in [[#hostapd|hostapd]] configuration.
WiFi is visible but no *IP address* is assigned -- configure [[#dnsmasq|dnsmasq]] section.
You can connect to WiFi and an IP address is assigned but *internet* does not
work -- check network connection of the source adapter (_eth0_ in this case)
and the [[#IPv4_Forwarding|IPv4 Forwarding]] configuration section.


#### script for wlan0
```bash
#!/bin/bash

# script to set up WiFi hotspot on Raspberry Pi 3

# install packages------------------------------------------
sudo apt-get install dnsmasq hostapd

# configure network-----------------------------------------
# backup /etc/dhcpcd.conf
sudo cp /etc/dhcpcd.conf /etc/dhcpcd.conf.orig

# add a line to /etc/dhcpcd.conf
sudo sh -c "echo denyinterfaces wlan0 >> /etc/dhcpcd.conf"

# backup /etc/network/interfaces
sudo cp /etc/network/interfaces /etc/network/interfaces.orig

# edit /etc/network/interfaces
text2add='allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    network 192.168.1.0
    broadcast 192.168.1.255
#    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf'
sudo sh -c "echo \'${text2add}\' >> /etc/network/interfaces"

# restart dhcpcd
sudo service dhcpcd restart

# reset wlan0 settings
sudo ifdown wlan0; sudo ifup wlan0

# configuring hostapd---------------------------------------
# backup /etc/hostapd/hostapd.conf if exits
if [ -f /etc/hostapd/hostapd.conf ]; then
  sudo cp /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.orig
fi

# edit /etc/hostapd/hostapd.conf
MY_SSID="<my_ssid>"
MY_PWD="<my_password>"
text2add="# This is the name of the WiFi interface we configured above
interface=wlan0
# Use the nl80211 driver with the brcmfmac driver
driver=nl80211
# This is the name of the network
ssid=${MY_SSID}            # SSID_VASI_WIFI
# Use the 2.4GHz band
hw_mode=g
# Use channel 6
channel=6
# Enable 802.11n
ieee80211n=1
# Enable WMM
wmm_enabled=1
# Enable 40MHz channels with 20ns guard interval
ht_capab=[HT40][SHORT-GI-20][DSSS_CCK-40]
# Accept all MAC addresses
macaddr_acl=0
# Use WPA authentication
auth_algs=1
# Require clients to know the network name
ignore_broadcast_ssid=0
# Use WPA2
wpa=2
# Use a pre-shared key
wpa_key_mgmt=WPA-PSK
# The network passphrase
wpa_passphrase=${MY_PWD}        #HESLO_DO_VASI_WIFI
# Use AES, instead of TKIP
rsn_pairwise=CCMP"
sudo sh -c "echo ${text2add} >> /etc/hostapd/hostapd.conf"

# test if everything works
sudo /usr/sbin/hostapd /etc/hostapd/hostapd.conf

# autoboot hotspot on startup (find #DAEMON_CONF="" in /etc/default/hostapd and replace it with DAEMON_CONF="/etc/hostapd/hostapd.conf"
sudo cp /etc/default/hostapd /etc/default/hostapd.orig # backup
sudo sed -i -e 's/#DAEMON_CONF=""/DAEMON_CONF="/etc/hostapd/hostapd.conf"/g' /etc/default/hostapd  # replace

# dnsmasq configuration-------------------------------------
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig # backup

text2add="interface=wlan0                           # Use interface wlan0
listen-address=192.168.1.1                # Explicitly specify the address to listen on
bind-interfaces                           # Bind to the interface to make sure we aren't sending things elsewhere
server=8.8.8.8                            # Forward DNS requests to Google DNS
domain-needed                             # Don't forward short names
bogus-priv                                # Never forward addresses in the non-routed address spaces.
dhcp-range=192.168.1.10,192.168.1.100,12h # Assign IP addresses between 192.168.1.10 and 192.168.1.100 with a 12 hour lease time"

sudo sh -c "echo ${text2add} >> /etc/dnsmasq.conf"

# ipv4 forwarding-------------------------------------------
sudo cp /etc/sysctl.conf /etc/sysctl.conf.orig # backup
sudo sed -i -e 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf # replace line

sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"  # reread the settings

# set up IP tables-----------------------------------------
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

# save the IP tables configuration
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"

# set up automatic reading of IP tables configuration with boot
sudo cp /etc/rc.local /etc/rc.local.orig # backup
text2add="iptables-restore < /etc/iptables.ipv4.nat

exit 0"
sudo sed 's/exit 0/'"${text2add}"'/g' /etc/rc.local
#awk '/exit 0/ { print; print "'"${text2add}"'"; next }1' /etc/rc.local

# start the services
sudo service hostapd start
sudo service dnsmasq start
```

### Raspberry Pi 4
#### wlan1
Needs wlan1 device to have *persistent name* and *static IP address*.

```bash
#!/bin/bash


function backup() {
  sudo cp "$1" "$1".orig
}

# change dir to /etc
cd /etc

# install the packages
# sudo apt-get install dnsmasq hostapd

# commit git repository
sudo git add .
sudo git commit -m "Just before hotspot setup"

# add interface to the end of /etc/dhcpcd.conf
echo "[+] /etc/dhcpcd.conf"
backup /etc/dhcpcd.conf
text="
interface wlan1
    static ip_address=10.0.1.1/24
    nohook wpa_supplicant
"
sudo bash -c "echo \"${text}\" >> /etc/dhcpcd.conf"

# restart dhcpcd service
sudo systemctl restart dhcpcd

# configuring DHCP server (dnsmasq)
echo "[+] /etc/dnsmasq.conf"
backup /etc/dnsmasq.conf
text="interface=wlan1
listen-address=10.0.1.1
bind-interfaces
server=8.8.8.8
domain-needed
bogus-priv
dhcp-range=10.0.1.2,10.0.1.30,255.255.255.0,24h"
sudo bash -c "echo \"${text}\" > /etc/dnsmasq.conf"

# reload DHCP service
sudo systemctl reload dnsmasq

# configure the access point host software (hostapd)
echo "[+] /etc/hostapd/hostapd.conf"
if [ -f /etc/hostapd/hostapd.conf ]; then
  backup /etc/hostapd/hostapd.conf
fi
MY_SSID="<my_ssid>"
MY_PSWD="<my_password>"
text="interface=wlan1
#driver=nl80211
ssid=${MY_SSID}
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=${MY_PSWD}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP"
sudo bash -c "echo \"${text}\" >> /etc/hostapd/hostapd.conf"
sudo sed -i -e 's/#DAEMON_CONF=\"\"/DAEMON_CONF=\"\/etc\/hostapd\/hostapd.conf\"/g' /etc/default/hostapd

# start the services
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd

# add routing and masqerade
echo "[+] /etc/sysctl.conf"
sudo sed -i -e 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

# add a masqerade for outbound traffic on wlan0
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan1 -o eth0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan1 -o wlan0 -j ACCEPT
sudo bash -c "iptables-save > /etc/iptables.ipv4.nat"

# edit /etc/rc.local to install these rules on boot
echo "[+] /etc/rc.local"
if [ -f /etc/rc.local ]; then
  backup /etc/rc.local
fi
sudo sed -i -e '$s/exit 0/iptables-restore < \/etc\/iptables.ipv4.nat/g' /etc/rc.local
sudo bash -c "echo >> /etc/rc.local"
sudo bash -c "echo 'exit 0' >> /etc/rc.local"
```


# swap size
```bash
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo chmod 600 /var/swap.1
sudo /sbin/swapon /var/swap.1
```

# APT
## search for package
```bash
apt-cache search sed | grep -E '^sed'
```

## show package info
```bash
apt-cache show sed
```

# VLC
## nvlc
`nvlc` is equal to `vlc -I ncurses`

to run in monochrome:
`nvlc --no-color`

custom start directory for Browser:
`nvlc --browse-dir /home/pi/Downloads`



[back to index](index.md)
