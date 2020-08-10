# Contents

- [exim4](#exim4)
    - [install](#exim4#install)
    - [setup](#exim4#setup)
    - [provide username and password](#exim4#provide username and password)
    - [test setup](#exim4#test setup)
    - [TODO](#exim4#TODO)
- [redirect local mails](#redirect local mails)
- [getmail](#getmail)
    - [install](#getmail#install)
    - [setup](#getmail#setup)
- [procmail](#procmail)
    - [install](#procmail#install)
    - [general setup](#procmail#general setup)
    - [setup local mail processing](#procmail#setup local mail processing)
- [mbsync](#mbsync)
    - [install](#mbsync#install)
    - [setup](#mbsync#setup)
- [gpg2](#gpg2)
    - [install](#gpg2#install)
    - [setup](#gpg2#setup)
- [mutt](#mutt)
    - [install](#mutt#install)
    - [muttrc](#mutt#muttrc)
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
read_all = false
delete = false
message_log = ~/.getmail/rpi3-tomek-gmail.log
delivered_to = false
received = false
verbose = 2
```
here the destination was to forward all incoming mails to __procmail__ for
filtering and processing.


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
On case of Error exith with __75__.

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

# mbsync
## install

## setup

# gpg2
## install

## setup

# mutt
## install

## muttrc

## bindings

## accounts

## colors

## signatures

## mailcap



[back to index](index.md)
