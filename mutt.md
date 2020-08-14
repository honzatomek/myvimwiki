# Contents

- [exim4](#exim4)
    - [install](#exim4#install)
    - [setup](#exim4#setup)
    - [provide username and password](#exim4#provide username and password)
    - [test setup](#exim4#test setup)
    - [TODO](#exim4#TODO)
- [msmtp](#msmtp)
    - [install](#msmtp#install)
    - [setup](#msmtp#setup)
    - [test setup](#msmtp#test setup)
- [redirect local mails](#redirect local mails)
- [getmail](#getmail)
    - [install](#getmail#install)
    - [setup](#getmail#setup)
- [procmail](#procmail)
    - [install](#procmail#install)
    - [general setup](#procmail#general setup)
    - [setup local mail processing](#procmail#setup local mail processing)
- [isync/mbsync](#isync/mbsync)
    - [install](#isync/mbsync#install)
    - [certificate files](#isync/mbsync#certificate files)
    - [setup](#isync/mbsync#setup)
- [gpg2](#gpg2)
    - [install](#gpg2#install)
    - [commands](#gpg2#commands)
    - [use gpg2 for password protection](#gpg2#use gpg2 for password protection)
    - [password cache](#gpg2#password cache)
- [mutt](#mutt)
    - [install](#mutt#install)
    - [muttrc](#mutt#muttrc)
        - [basic `.muttrc` setup:](#mutt#muttrc#basic `.muttrc` setup:)
        - [advanced `.muttrc` setup](#mutt#muttrc#advanced `.muttrc` setup)
        - [script to add mailboxes](#mutt#muttrc#script to add mailboxes)
    - [bindings](#mutt#bindings)
    - [accounts](#mutt#accounts)
    - [colors](#mutt#colors)
    - [signatures](#mutt#signatures)
    - [mailcap](#mutt#mailcap)

# exim4
From: https://linuxcommando.blogspot.com/2014/04/how-to-setup-exim4-on-debian-to-use.html?m=1

__Exim4__ is highly configurable and flexible __MTA__ (Mail Transfer Agent is a program 
that deals with transfering mails from one account to another.), with 
functionality other MTAs lack. Opposed to __Sendmail__ it has comprehensible
config files which is a reason some admins prefer it.
Homepage: http://www.exim.org/

Exim4 allows to:
- __send__ e-mail
- redirect __root__ e-mails to user

> __for this setup to work with gmail, gmail must be configured to allow__
> __less secure apps__ !!!

## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install exim4
```

## setup
to set-up exim4 for __gmail__ run:
`sudo dpkg-reconfigure exim4-config`

A form appears, select:
- General type of mail configuration
> mail sent by smarthost; received via SMTP or fetchmail

- System mail name:
> localhost

- IP-addresses to listen on for incoming SMTP connections:
> 127.0.0.1

- Other destinations for which mail is accepted:
> _leave empty_

- Machines to relay mail for:
> _leave empty_ 

- IP address or host name of the outgoing smarthost:
> smtp.gmail.com::587

- Hide local mail name in outgoing mail?
> No

- Keep nuber of DNS-queries minimal (Dial-on-Demand)?
> No

- Delivery method for local mail:
> mbox format in /var/mail/

- Split configuration into small files?
> No

## provide username and password
Append the following to `/etc/exim4/passwd.client` with the proper __Gmail__
__account__ and __password__:

`*.google.com:yourAccount@gmail.com:yourPassword`

This password file contains sensitive account information. You should verify 
its file permissions and ownership.

```bash
$ ls -al /etc/exim4/passwd.client
-rw-r----- 1 root Debian-exim 252 Mar 25 17:24 /etc/exim4/passwd.client
```

If they are different from the above, use the following commands to set file 
permissions and ownership.

```bash
$ sudo chown root:Debian-exim /etc/exim4/passwd.client
$ sudo chmod 640 /etc/exim4/passwd.client
Reload exim4.
$ sudo update-exim4.conf
$ invoke-rc.d exim4 restart
[ ok ] Stopping MTA for restart: exim4_listener.
[ ok ] Restarting MTA: exim4.
$ exim4 -qff
```

The `-qff` parameter forces a delivery attempt for every message, whether
frozen or not.

## test setup
To test, send an email to yourself, and check your Inbox:

```bash
$ echo test only | mail -s 'Test Subject' myAddress@gmail.com
```

If you open the email, you will see that the From address in the email header
is the Gmail account which you configured in `/etc/exim4/passwd.client`.

If you experience any issue with exim4, check its log file located at
`/var/log/exim4/mainlog`.

## TODO
- use __SSL/TLS__ Authentication using __GMail__ Certificates

# msmtp
From: https://wiki.archlinux.org/index.php/msmtp
an option to `exim4` for sending mail on linux (for example in `termux` `exim4` is not available)

## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install msmtp
# this is optional
sudo apt install msmtp-mta
```

`msmtp-mta` will create `sendmail` alias to `msmtp`

## setup
create `~/.msmtprc` with following settings:
```msmtprc
# default values for all accounts, the _defaults_ keyword is crucial
defaults
auth on
tls on
tls_trust_file ~/.cert/ca-certificates.crt
logfile ~/.msmtp/msmtp.log

# rpi3.tomek@gmail.com
account rpi3-tomek@gmail-com
host smtp.gmail.com
port 587
from rpi3.tomek@gmail.com
user rpi3.tomek
#password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
passwordeval "gpg -q --for-your-eyes-only --no-tty -d ~/.auth/authinfo.gpg | awk '/machine smtp.gmail.com login rpi3.tomek@gmail.com/ {print $NF}'"

# multiple accounts can be set starting the _account_ keyword

# set default account
account default : rpi3-tomek@gmail-com

# vim: ft=rc
```

`ca-certificates.crt` file can be usually found in `/etc/ssl/certs/ca-certtificates.crt`
but the package needs to be installed:
```bash
sudo apt install ca-certificates
```

a password can be either input in the `rc file`, then the `.msmtprc` file should have __0600__ rights set
```bash
chmod 0600 ~/.msmtprc
```

if gpg is used and the beforementioned command is used to decrypt auth file then the auth file has following format:
```
machine imap.gmail.com login rpi3.tomek@gmail.com password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
machine smtp.gmail.com login rpi3.tomek@gmail.com password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
```
multiple accounts can be set

if only one account is needed or a setup with one account per file is preferred, use:
```bash
passwordeval "gpg -q --for-your-eyes-only --no-tty -d ~/.auth/rpi3.tomek@gmail.com.gpg"
```
then the file should have only contaiin the password

## test setup
use following command to test whether the `.msmtprc` file was set up correctly:
```bash
echo "Hello there!" | msmtp -a default recipient@gmail.com
```
the `-a|--account=` option sets the account to use for sending mail

you can also send a file to the msmtp command with more info:
```bash
cat << EOF | msmtp -a default 
To: username@domail.com
From: username@domain.com
Subject: this is a subject

This is the mail body.
EOF
```

if just `msmtp -a default recipient@provider.com` command is used, then you can write a message bellow
and end writing the message using `Ctrl-D` command


# redirect local mails
From: https://linuxcommando.blogspot.com/2014/04/redirect-local-emails-to-remote-email.html

To either redirect root mails to user or root/user mail to an Internet e-mail
accoount it is necessary to edit `/etc/aliases` as __root__:

```bash
# /etc/aliases
mailer-daemon: postmaster
postmaster: root
nobody: root
hostmaster: root
usenet: root
news: root
webmaster: root
www: root
ftp: root
abuse: root
noc: root
security: root
root: pi
```

On the last line the __root__ mail is redirected to user __pi__.
Because the __exim4__ is set up, a following line will also work:
`root: mymail@whatever.com`

If the MTA is not exim4, it is necessary to rebuild the aliases database using:
```bash
newaliases
```
command.

# getmail
From: https://www.linode.com/docs/email/clients/retrieve-email-using-getmail/
From: http://pyropus.ca/software/getmail/configuration.html
From: https://wiki.archlinux.org/index.php/Getmail#Password_management

__Getmail__ is a simple mail retriever. In many ways, the software is a response to
the complexity of __fetchmail__. Getmail provides a simple and efficient tool for
downloading email from POP (Post Office Protocol) and IMAP (Internet Messaged
Access Protocol) servers. It is written in python and config file structure is
ConfigParser compliant.

## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install getmail
```

## setup
Configuration is stored in `~/.getmail/getmailrc` file. `getmail` command looks
only into `~/.getmail` directory. If multiple accounts must be specified,
store them as separate files in `~/.getmail` directory.

Get mails:
`getmail -a` - get all mail -> duplicates already downloaded mail
`getmail -n` - get new mail

If config is stored elsewhere, then __getmail__ must be run with following command:
`getmal -r ~/.accounts/account1`

Configuring IMAP:
```python config
[retriever]
type = SimpleIMAPSSLRetriever
server = imap.gmail.com
port = 993
username = rpi3.tomek
password = MYSUPERSECRETPASSWORDWHICHISALSOEXTRALONG

[destination]
type = MDA_external
path = /usr/bin/procmail
arguments = ("-f", "%(sender)", "-m", "/home/pi/.procmail/procmailrc")

[options]
read_all = False
delete = False
message_log = ~/.getmail/rpi3-tomek-gmail.log
delivered_to = False
received = False
verbose = 2
```
here the destination was to forward all incoming mails to __procmail__ for
filtering and processing.

there is a possibility to use `GPG encrypted` password:
```python config
password_command = ("gpg", "-q", "--for-your-eyes-only", "--no-tty", "-d", "~/.auth/authinfo.gpg", "|", "awk", "'/machine smtp.gmail.com login rpi3.tomek@gmail.com/ {print $NF}'")
```

if gpg is used and the beforementioned command is used to decrypt auth file then the auth file has following format:
```
machine imap.gmail.com login rpi3.tomek@gmail.com password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
machine smtp.gmail.com login rpi3.tomek@gmail.com password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
```
multiple accounts can be set.

# procmail
__Procmail__ is a MDA (Mail Delivery Agent) that using _recipes_ processes,
filters and redirects e-mail.

## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install procmail
```

## general setup
A `~/.procmailrc` file is neccesary, this one is read automatically, if exists.

To use different `rc file` for different accounts you can create a file in
`~/.procmail/` directory and speciffically tell `procmail` to use it with
`-m` option.

Example of `.procmailrc`:
```procmailrc
MAILDIR=$HOME/mail/
LOGFILE=$HOME/.procmail/procmail.log
VERBOSE=yes
# avoid duplicate messages
PMDIR=$HOME/.procmail/
# Mailing lists
# debian.user
:0
* ^TO_.*@raspberrypi.*
{
# avoid duplicate messages
:0 Whc: msgid.lock
| formail -D 16384 $PMDIR/idcache
# and delete the duplicates
:0 a:
/dev/null
# pi user
:0
* ^TO_pi@raspberrypi
pi/inbox/
# root user
:0
* ^TO_root@raspberrypi
root/inbox/
}
# avoid duplicate messages
:0 Whc: msgid.lock
| formail -D 16384 $PMDIR/idcache
# and delete the duplicates
:0 a:
/dev/null
# All other mail goes to inbox
:0
rpi3-tomek@gmail-com/inbox/
```

## setup local mail processing
To use __procmail__ for local mail processing a `~/.forward` file is necessary:
```forward
| /usr/bin/procmail -m /home/pi/.procmail/procmailrc || exit 75 #pi
```
`|` means pipe mail to: `/usr/bin/procmail` with `-m` custom __rc file__.
On case of Error exit with __75__.

Or you can process system mail in `/var/mail` manually:
```bash
# for own user
formail -s /usr/bin/procmail -m /home/pi/.procmail/procmailrc </var/mail/pi
```

```bash
# for root
sudo cp /var/mail/mail /home/pi/tmp/root_mail
sudo chown pi /home/pi/tmp/root_mail
formail -s /usr/bin/procmail -m /home/pi/.procmail/procmailrc <~/tmp/root_mail
```

`formail -s` runs each mail from mbox format through external program, here
`procmail` with specific `rc file` is used.

# isync/mbsync
From: https://webgefrickel.de/blog/a-modern-mutt-setup

Synchronises internet e-mail account with `Maildir` directory structure stored
locally on the computer using IMAP protocol.

## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install isync
```

## certificate files
there are three certificate files in the following setup

1. `ca-certificates.crt`, for this the `ca-certicates` should be installed:
```bash
sudo apt install ca-certtificates
```
then this certificate file shoudld be located in:
`/etc/ssl/certs/ca-certificates.crt`

2. the google certificates
From: https://wiki.archlinux.org/index.php/isync

to get google certificates use:
```bash
openssl s_client -connect smtp.gmail.com:465 -showcerts 2>&1 < /dev/null > cert
```

a following output will be saved into the `cert` file:
```
depth=2 OU = GlobalSign Root CA - R2, O = GlobalSign, CN = GlobalSign
verify return:1
depth=1 C = US, O = Google Trust Services, CN = GTS CA 1O1
verify return:1
depth=0 C = US, ST = California, L = Mountain View, O = Google LLC, CN = smtp.gmail.com
verify return:1
CONNECTED(00000004)
---
Certificate chain
 0 s:C = US, ST = California, L = Mountain View, O = Google LLC, CN = smtp.gmail.com
   i:C = US, O = Google Trust Services, CN = GTS CA 1O1
-----BEGIN CERTIFICATE-----
MIIEyDCCA7CgAwIBAgIRANnY19sA42hwCAAAAABNn0kwDQYJKoZIhvcNAQELBQAw
QjELMAkGA1UEBhMCVVMxHjAcBgNVBAoTFUdvb2dsZSBUcnVzdCBTZXJ2aWNlczET
MBEGA1UEAxMKR1RTIENBIDFPMTAeFw0yMDA3MTUwODMzMDhaFw0yMDEwMDcwODMz
MDhaMGgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpDYWxpZm9ybmlhMRYwFAYDVQQH
Ew1Nb3VudGFpbiBWaWV3MRMwEQYDVQQKEwpHb29nbGUgTExDMRcwFQYDVQQDEw5z
bXRwLmdtYWlsLmNvbTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABJLziSDMl8+8
mT2oq6AXKvF4XoqWHuwV3JTzG/eBlo4byXTXb/HbBEeJW+SaDYk/mXoexODCtjQB
UVzJNG5Qjs2jggJcMIICWDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYB
BQUHAwEwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU8Cv9lvZRU4kTOBQQrIM15pnE
6qkwHwYDVR0jBBgwFoAUmNH4bhDrz5vsYJ8YkBug630J/SswaAYIKwYBBQUHAQEE
XDBaMCsGCCsGAQUFBzABhh9odHRwOi8vb2NzcC5wa2kuZ29vZy9ndHMxbzFjb3Jl
MCsGCCsGAQUFBzAChh9odHRwOi8vcGtpLmdvb2cvZ3NyMi9HVFMxTzEuY3J0MBkG
A1UdEQQSMBCCDnNtdHAuZ21haWwuY29tMCEGA1UdIAQaMBgwCAYGZ4EMAQICMAwG
CisGAQQB1nkCBQMwMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5wa2kuZ29v
Zy9HVFMxTzFjb3JlLmNybDCCAQQGCisGAQQB1nkCBAIEgfUEgfIA8AB1AMZSoOxI
zrP8qxcJksQ6h0EzCegAZaJiUkAbozYqF8VlAAABc1HSE4oAAAQDAEYwRAIgeC/2
KD4kef6ALvdhAQ+QkCaYlTBfH7s7CSnxaO/g8xACIDx2oHIqeeE4YVaFcwFtNdlS
bGlTLZLauaFV4JJ69ss7AHcAsh4FzIuizYogTodm+Su5iiUgZ2va+nDnsklTLe+L
kF4AAAFzUdITdgAABAMASDBGAiEA8cpWAncjRNezQfi9gIjd8pq8HAhyn0ZkBH3v
v5nM/JsCIQDJp/oYSeeNNlZA7RyjY/dRbEP2IkFmm3rE3QY7owRe8TANBgkqhkiG
9w0BAQsFAAOCAQEAS5BeVd/nvbjGclc7hZa1OX3TZ095rjniN5R7C7TFk/C7i+0Y
AvygPGclNnBk/C4IHJ+QPkqIzAMmT1i2oFqHCPXZRN+gOZAZbNifwjilBKK6HZ/4
pqTIfw3+6aom+Y65ROxwvpOXdt/VDOVTD88lKR2v0NUDQHzrB/NLauyjqn3XLRtS
LnMzoyhVUL4ugt/mWPh8kZ0M3Fo7VSVsp3ysVLh4E8TUnvHs+BIp9CUxDR60vda+
bqURnAsF7wJL1lkPZLnOUh6zMJkEqm8xXUg+KBbcLCtDCsQPR3Tdwtn2oIPTU3Li
B+HemGfeih42kLNAHkqnmaye0WIRSBJeX4y2lg==
-----END CERTIFICATE-----
 1 s:C = US, O = Google Trust Services, CN = GTS CA 1O1
   i:OU = GlobalSign Root CA - R2, O = GlobalSign, CN = GlobalSign
-----BEGIN CERTIFICATE-----
MIIESjCCAzKgAwIBAgINAeO0mqGNiqmBJWlQuDANBgkqhkiG9w0BAQsFADBMMSAw
HgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMjETMBEGA1UEChMKR2xvYmFs
U2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNzA2MTUwMDAwNDJaFw0yMTEy
MTUwMDAwNDJaMEIxCzAJBgNVBAYTAlVTMR4wHAYDVQQKExVHb29nbGUgVHJ1c3Qg
U2VydmljZXMxEzARBgNVBAMTCkdUUyBDQSAxTzEwggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDQGM9F1IvN05zkQO9+tN1pIRvJzzyOTHW5DzEZhD2ePCnv
UA0Qk28FgICfKqC9EksC4T2fWBYk/jCfC3R3VZMdS/dN4ZKCEPZRrAzDsiKUDzRr
mBBJ5wudgzndIMYcLe/RGGFl5yODIKgjEv/SJH/UL+dEaltN11BmsK+eQmMF++Ac
xGNhr59qM/9il71I2dN8FGfcddwuaej4bXhp0LcQBbjxMcI7JP0aM3T4I+DsaxmK
FsbjzaTNC9uzpFlgOIg7rR25xoynUxv8vNmkq7zdPGHXkxWY7oG9j+JkRyBABk7X
rJfoucBZEqFJJSPk7XA0LKW0Y3z5oz2D0c1tJKwHAgMBAAGjggEzMIIBLzAOBgNV
HQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFJjR+G4Q68+b7GCfGJAboOt9Cf0rMB8G
A1UdIwQYMBaAFJviB1dnHB7AagbeWbSaLd/cGYYuMDUGCCsGAQUFBwEBBCkwJzAl
BggrBgEFBQcwAYYZaHR0cDovL29jc3AucGtpLmdvb2cvZ3NyMjAyBgNVHR8EKzAp
MCegJaAjhiFodHRwOi8vY3JsLnBraS5nb29nL2dzcjIvZ3NyMi5jcmwwPwYDVR0g
BDgwNjA0BgZngQwBAgIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9wa2kuZ29vZy9y
ZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAGoA+Nnn78y6pRjd9XlQWNa7H
TgiZ/r3RNGkmUmYHPQq6Scti9PEajvwRT2iWTHQr02fesqOqBY2ETUwgZQ+lltoN
FvhsO9tvBCOIazpswWC9aJ9xju4tWDQH8NVU6YZZ/XteDSGU9YzJqPjY8q3MDxrz
mqepBCf5o8mw/wJ4a2G6xzUr6Fb6T8McDO22PLRL6u3M4Tzs3A2M1j6bykJYi8wW
IRdAvKLWZu/axBVbzYmqmwkm5zLSDW5nIAJbELCQCZwMH56t2Dvqofxs6BBcCFIZ
USpxu6x6td0V7SvJCCosirSmIatj/9dSSVDQibet8q/7UK4v4ZUN80atnZz1yg==
-----END CERTIFICATE-----
---
Server certificate
subject=C = US, ST = California, L = Mountain View, O = Google LLC, CN = smtp.gmail.com

issuer=C = US, O = Google Trust Services, CN = GTS CA 1O1

---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: ECDSA
Server Temp Key: X25519, 253 bits
---
SSL handshake has read 2641 bytes and written 396 bytes
Verification: OK
---
New, TLSv1.3, Cipher is TLS_AES_256_GCM_SHA384
Server public key is 256 bit
Secure Renegotiation IS NOT supported
No ALPN negotiated
Early data was not sent
Verify return code: 0 (ok)
---
DONE
```

then two certificates enclosed in `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`.
savve the two respective keys to `*.pem` files for further use.


## setup
Create either `~/.mbsyncrc` or `~/.mbsync/mbsyncrc` file.
Multiple accounts can be specified under each other in one file or each account
can be specified in a separate file and run manually.

```mbsyncrc
IMAPAccount rpi3-tomek@gmail-com
# Address to connect to
Host imap.gmail.com
User rpi3.tomek@gmail.com
#Pass MYSUPERSECRETPASSWHICHISALSOLONGASHELL
# To store the password in an encrypted file use PassCmd instead of Pass
# PassCmd "gpg2 -q --for-your-eyes-only --no-tty -d ~/.mailpass.gpg"
PassCmd "gpg2 -q --for-your-eyes-only --no-tty -d ~/.mbsync/.authinfo.gpg | awk '/machine imap.gmail.com login rpi3.tomek@gmail.com/ {print $NF}'"
#
# Use SSL
SSLType IMAPS
# The following line should work. If get certificate errors, uncomment the two following lines and read the "Troubleshooting" section.
CertificateFile /etc/ssl/certs/ca-certificates.crt
CertificateFile ~/.certificates/gmail.pem
CertificateFile ~/.certificates/google.pem

IMAPStore rpi3-tomek@gmail-com-remote
Account rpi3-tomek@gmail-com

MaildirStore rpi3-tomek@gmail-com-local
Subfolders Verbatim
# The trailing "/" is important
Path ~/mail/rpi3-tomek@gmail-com/
Inbox ~/mail/rpi3-tomek@gmail-com/inbox

# Global config for all Channels
# Sync both ways
Sync All
# Mail removal both ways
Remove Both
# Automatically create missing mailboxes, both locally and on the server
Create Both
# Automatically delete mails on both Master and Slave
#Expunge Both

Channel rpi3-tomek@gmail-com_inbox
Master :rpi3-tomek@gmail-com-remote:"Inbox"
Slave :rpi3-tomek@gmail-com-local:inbox
# Exclude everything under the internal [Gmail] folder, except the interesting folders
#Patterns * ![Gmail]* "[Gmail]/Sent Mail" "[Gmail]/Starred" "[Gmail]/All Mail"
# Or include everything
#Patterns *

Channel rpi3-tomek@gmail-com_sent
Master :rpi3-tomek@gmail-com-remote:"[Gmail]/Sent Mail"
Slave :rpi3-tomek@gmail-com-local:sent

Channel rpi3-tomek@gmail-com_drafts
Master :rpi3-tomek@gmail-com-remote:"[Gmail]/Drafts"
Slave :rpi3-tomek@gmail-com-local:drafts

Channel rpi3-tomek@gmail-com_important
Master :rpi3-tomek@gmail-com-remote:"[Gmail]/Important"
Slave :rpi3-tomek@gmail-com-local:important

Channel rpi3-tomek@gmail-com_archive
Master :rpi3-tomek@gmail-com-remote:"backup"
Slave :rpi3-tomek@gmail-com-local:archive
Patterns * ![Gmail]* !INBOX !other

Channel rpi3-tomek@gmail-com_spam
Master :rpi3-tomek@gmail-com-remote:"[Gmail]/Spam"
Slave :rpi3-tomek@gmail-com-local:spam

Channel rpi3-tomek@gmail-com_starred
Master :rpi3-tomek@gmail-com-remote:"[Gmail]/Starred"
Slave :rpi3-tomek@gmail-com-local:starred

Channel rpi3-tomek@gmail-com_trash
Master :rpi3-tomek@gmail-com-remote:"[Gmail]/Trash"
Slave :rpi3-tomek@gmail-com-local:trash

Channel rpi3-tomek@gmail-com_custom
Master :rpi3-tomek@gmail-com-remote:"other"
Slave :rpi3-tomek@gmail-com-local:other
# Exclude everything under the internal [Gmail] folder
Patterns * ![Gmail]* !INBOX !backup
# Or include everything
#Patterns *

# Create Channel Group
Group rpi3-tomek@gmail-com
Channel rpi3-tomek@gmail-com_inbox
Channel rpi3-tomek@gmail-com_sent
Channel rpi3-tomek@gmail-com_drafts
Channel rpi3-tomek@gmail-com_important
Channel rpi3-tomek@gmail-com_archive
Channel rpi3-tomek@gmail-com_spam
Channel rpi3-tomek@gmail-com_starred
Channel rpi3-tomek@gmail-com_trash
Channel rpi3-tomek@gmail-com_custom

# Save the synchronization state files in the relevant directory
SyncState *
CopyArrivalDate yes
```

the `CopyArrivalDate yes` command is used to correct the incoming mails if their arrival date is wrong

# gpg2
## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install gnupg2
```

## commands
generate private and public key pair
```bash
gpg2 --full-gen-key
```

generate revoke key
```bash
gpg --gen-revoke --armor --output=revocation_certificate.asc rpi3.tomek@protonmail.com
```

list all public keys in keychain
```bash
gpg2 --list-keys
```

sample output:
> /home/pi/.gnupg/pubring.kbx
> ---------------------------
> sec   rsa2048 2020-08-10 [SC]
>       4732383F30804F96ED196F261861D020BB1C9C6B
> uid           [ultimate] Jan Tomek (my RaspberryPi address) <rpi3.tomek@gmail.com>
> ssb   rsa2048 2020-08-10 [E]


list all private keys in keychain
```bash
gpg2 --list-secret-keys --keyid-format LONG
```

edit specified key
```bash
gpg2 --edit-key jan.tomek@protonmail.com
```

export public key specified by its signature
```bash
gpg2 --armor --export 4E6C6CA10422850FAC7BA32C2D9E8DA003F67772 >> jan.tomek@protonmail.com.pem
```

export default private key
```bash
gpg2 --armor --export-secret-keys >> rpi3.tomek@gmail.com.priv.asc
```

delete a key from keychain
```bash
gpg2 --delete-secret-and-public-keys jan.tomek@protonmail.com
```

encrypt a file (only persons specified as recipients will be able to decrypt it)
```bash
gpg2 --recipient jan.tomek@protonmail.com --recipient rpi3.tomek@gmail.com --encrypt .authinfo
```

change private key passphrase (or delete it entirely)
From: https://help.ubuntu.com/community/GnuPrivacyGuardHowto
1. first invoke the edit key command
```bash
gpg2 --edit-key KEYID
```
2. then in the gpg prompt enter passwd command and follow the instructions
```gpg
gpg> passwd
```

## use gpg2 for password protection
first create a file storing all sensitive info
```
machine imap.gmail.com login rpi3.tomek@gmail.com password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
machine smtp.gmail.com login rpi3.tomek@gmail.com password MYSUPERSECRETPASSWORDWHICHISALSOLONGASFUCK
```

encrypt the file:
```bash
gpg2 --enccrypt file
```
a `file.gpg` will be created.

then use the following command to extract the password
```bash
gpg2 -q --for-your-eyes-only --no-tty -d ~/.mbsync/.authinfo.gpg | awk '/machine imap.gmail.com login rpi3.tomek@gmail.com/ {print $NF}'
```

if only the password is needed, then __just the password__ can be stored in a file and the following command used to get it:
```bash
gpg2 -q --for-your-eyes-only --no-tty -d ~/.mbsync/.authinfo.gpg
```

## password cache
for the gpg-agent not to ask for password each time, either create or edit the `~/.gnupg/gpg-agent.conf` file
```conf
this sets the pass duration to 200 hrs
pinentry-program /usr/bin/pinentry-qt4
default-cache-ttl 720000
max-cache-ttl 720000
```
this should cache the passwords for 200 hours or untill logoff

to be able to run `--export` command from tty use:
```conf
pinentry-program /usr/bin/pinentry-curses
default-cache-ttl 720000
max-cache-ttl 720000
```

# mutt
From: https://webgefrickel.de/blog/a-modern-mutt-setup
From: https://webgefrickel.de/blog/a-modern-mutt-setup-part-two
`mutt` is a CLI e-mail client with native support for smtp, imap and pgp
`mutt` supports both `mbox` and `maildir` format. tthe difference between the two
is that `mbox` stores all mails in one file while `maildir` stores them in a folder
structure one mail per file.

each maildir `directory` contains three subdirectories: `tmp`, `cur` and `new`

## install
```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install mutt
```

## muttrc
basic configuration is stored in either `~/.muttrc` or `~/.mutt/muttrc`

If `set sidebar_short_path` does not show corretly:
!!! beware: https://gitlab.com/muttmua/mutt/-/issues/194

### basic `.muttrc` setup:
```muttrc
set folder="/home/pi/mail/rpi3-tomek@gmail-com/"
set mbox_type=maildir
set mbox="/home/pi/mail/rpi3-tomek@gmail-com/inbox/"
set spoolfile="/home/pi/mail/rpi3-tomek@gmail-com/inbox/"
set record="/home/pi/mail/rpi3-tomek@gmail-com/sent/"

mailboxes /home/pi/mail/rpi3-tomek@gmail-com/inbox home/pi/mail/pi
set editor=vim
set sort=threads
set include=yes
set indent_str="> "

# vim: ft=muttrc
```

### advanced `.muttrc` setup
From: https://webgefrickel.de/blog/a-modern-mutt-setup-part-two
1. paths:
```muttrc
# paths
set folder = ~/mail
set header_cache = ~/.mutt/cache/headers
set message_cachedir = ~/.mutt/cache/bodies
set mailcap_path = ~/.mutt/mailcap
set tmpdir = ~/.mutt/tmp
set sendmail = /data/data/com.termux/files/usr/bin/msmtp
```
the `sendmail` option is necessary if either `eximm4` or `msmtp-mta` are not installed
or set up. then `msmtp` needs to be installed, set up and speciied.

2. basic options:
```muttrc
# basic options
set wait_key = no
set mbox_type = Maildir
set timeout = 3
set mail_check = 0
set delete
set quit
set thorough_search
set mail_check_stats
unset confirmappend
unset move
unset mark_old
unset beep_new
```

3. compose view options:
```muttrc
# compose view options
set envelope_from                    # which from?
set edit_headers                     # show headers when composing
set askcc                            # ask for CC:
set fcc_attach                       # save attachments with the body
set forward_format = "Fwd: %s"       # format of subject when forwarding
set forward_decode                   # decode when forwarding
set attribution = "On %d, %n wrote:" # format of quoting header
set reply_to                         # reply to Reply to: field
set reverse_name                     # reply as whomever it was to
set include                          # include message in replies
set indent_str="> "
set forward_quote                    # include message in forwards
set editor = vim
set sig_on_top
set text_flowed
unset sig_dashes                     # no dashes before sig
unset mime_forward                   # forward attachments as part of body
```

4. status bar, date format, finding stuff etc.
```muttrc
# status bar, date format, finding stuff etc.
set status_chars = " *%A"
set status_format = "[ Folder: %f ] [%r%m messages%?n? (%n new)?%?d? (%d to delete)?%?t? (%t tagged)? ]%>-%?p?( %p postponed )?"
set date_format = "%Y/%m/%d %H:%M"
set index_format = "%4C [%Z] %?X?A&-? %D  %-30.30n  %s"
set sort = threads
set sort_aux = reverse-last-date-received
set uncollapse_jump
set sort_re
set reply_regexp = "^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"
set quote_regexp = "^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"
set send_charset = "utf-8"
```

5. pager view options
```muttrc
# pager view options
set pager_index_lines = 10
set pager_context = 3
set pager_stop
set menu_scroll
set tilde
unset markers
# email headers and attachments
ignore *
unignore from: to: cc: bcc: date: subject:
unhdr_order *
hdr_order = from: to: cc: bcc: date: subject:
alternative_order text/plain text/enriched text/html
auto_view text/html

# when composing emails, use this command to get addresses from the addressbook with khard first,
# else from the mu index
set query_command = "( khard email --parsable '%s' | sed -n '1!p'; mu cfind --format=mutt-ab '%s' )"
```

6. sidebar patch config
```muttrc
# sidebar patch config
set sidebar_visible
set sidebar_short_path
set sidebar_folder_indent
set sidebar_width = 25
set sidebar_divider_char = '║' # single line '│' is U+2502 (Unicode Box Drawing character), double line '║' is U+2551
set sidebar_indent_string = ' '
set fast_reply                       # skip to compose when replying
set sidebar_format = "%B %* [%?N?%N / ?%S]"
```

7. mailboxes to show in the sidebar
```muttrc
# mailboxes to show in the sidebar
`~/.mutt/add_mailbox.sh "${HOME}/mail/"`
```

8. GPG/PGP
```muttrc
# source default values from /usr/share/doc/mutt/examples/gpg.rc.gz
source ~/.mutt/gpg.rc
set pgp_default_key="4732383F30804F96ED196F261861D020BB1C9C6B"

# override recommended gpg settings
set pgp_use_gpg_agent = yes
set crypt_use_gpgme = no
set crypt_autosign = no
set crypt_verify_sig = yes
set crypt_replysign = yes
set crypt_replyencrypt = yes
set crypt_replysignencrypted = yes
set pgp_encrypt_only_command="/data/data/com.termux/files/usr/bin/pgpewrap gpg --batch --quiet --no-verbose --output - --encrypt --textmode --armor --always-trust -- -r %r -- %f"
set pgp_encrypt_sign_command="/data/data/com.termux/files/usr/bin/pgpewrap gpg %?p?--passphrase-fd 0 --pinentry-mode=loopback? --batch --quiet --no-verbose --textmode --output - --encrypt --sign %?a?-u %a? --armor --always-trust -- -r %r -- %f"
```
the `pgpewrap` command needs to point to its executable - shown here is `termux` location
the `pgp_default_key` needs to be set a correct key in `gpg keyring` used for signing

9. source colors and keybindings
```muttrc 
# source colors and keybindings
# keeping those in one place makes it easier
source ~/.mutt/colors/dracula/dracula.muttrc
source ~/.mutt/bindings
# source aliases for mail addresses
source ~/.mutt/aliases
```

10. by default use rpi3-tomek@gmail-com
```muttrc 
# by default use rpi3-tomek@gmail-com
set realname = "Jan Tomek"
set spoolfile = "+rpi3-tomek@gmail-com/inbox"
source ~/.mutt/accounts/rpi3-tomek@gmail-com
```

11. when changing into other mailboxes, use different address etc.
```muttrc 
# when changing into other mailboxes, use different address etc.
folder-hook rpi3-tomek\@gmail-com/* source ~/.mutt/accounts/rpi3-tomek@gmail-com
```

12. vim modeline
```muttrrc
# vim: ft=muttrc
```

### script to add mailboxes
mutt v1.3 shorts paths in sidebar based on previously occuring strings
`~/.mutt/add_mailbox.sh`
```bash
#!/bin/bash

mail="$1"

#out=$(find "${mail}" -type d -name inbox | sed -E 's|'"${mail}"'|=|g'| sort | sed -E 's|=([^/]*)(/.*)\b|mailboxes =\1 =\1\2;|g' | xargs)

for d in $(find "${mail}" -mindepth 1 -maxdepth 1 -type d | sort); do
  o="mailboxes ${d/${mail}/=} ${d/${mail}/=}/inbox"
  o="${o} $(find "${d}" -mindepth 1 -type d \! -name new \! -name cur \! -name tmp \! -name inbox | sort | sed -E 's|'"${mail}"'|=|g' | xargs)"
  out="${out}${o}; "
done

echo "${out%%; }"
```

this behavior changes in v1.3.1, use:
```muttrc
# mailboxes to show in the sidebar
mailboxes ="ALL-INBOXES"
mailboxes ="==================="
`~/.mutt/add_inboxes.sh "${HOME}/mail/"`
mailboxes ="-------------------"
`~/.mutt/add_other.sh "${HOME}/mail/"`
```

and the scripts:
1. add_inboxes
`~/.mutt/add_inboxes.sh`
```bash
#!/bin/bash

mail="$1"

find "${mail}" -type d -name inbox | sed -E 's|'"${mail}"'|=|g'| sort | sed -E 's|=([^/]*)(/.*)\b|mailboxes =\1 =\1\2;|g' | xargs
```

2. add_other
`~/.mutt/add_other.sh`
```bash
#!/bin/bash

mail="$1"
out=""

for d in $(find "${mail}" -mindepth 1 -maxdepth 1 -type d | sort); do
  o="mailboxes ${d/${mail}/=}"
  o="${o} $(find "${d}" -mindepth 1 -type d \! -name new \! -name cur \! -name tmp \! -name inbox | sort | sed -E 's|'"${mail}"'|=|g' | xargs)"
  out="${out}${o}; "
done

echo "${out%%; }"
```

## bindings

## accounts

## colors

## signatures

## mailcap



[back to index](index.md)
