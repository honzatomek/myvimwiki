# Contents

- [exim4](#exim4)
    - [install](#exim4#install)
    - [setup](#exim4#setup)
    - [provide username and password](#exim4#provide username and password)
    - [test setup](#exim4#test setup)
- [getmail](#getmail)
    - [install](#getmail#install)
    - [setup](#getmail#setup)
- [procmail](#procmail)
    - [install](#procmail#install)
    - [setup](#procmail#setup)
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


# getmail
## install

## setup

# procmail
## install

## setup

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
