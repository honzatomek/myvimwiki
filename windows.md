# Contents

    - [disk](#disk)
        - [repair](#disk#repair)
            - [chkdsk](#disk#repair#chkdsk)
    - [linux terminal on win 10](#linux terminal on win 10)
        - [Windows Subsystem for Linux Installation](#linux terminal on win 10#Windows Subsystem for Linux Installation)
        - [Set your distribution version to WSL 1 or WSL 2](#linux terminal on win 10#Set your distribution version to WSL 1 or WSL 2)
        - [Install XFCE terminal](#linux terminal on win 10#Install XFCE terminal)
        - [install X server](#linux terminal on win 10#install X server)
        - [Run XFCE terminal](#linux terminal on win 10#Run XFCE terminal)
            - [Start VcXsrv](#linux terminal on win 10#Run XFCE terminal#Start VcXsrv)
            - [Configure X server address](#linux terminal on win 10#Run XFCE terminal#Configure X server address)
            - [Start the terminal](#linux terminal on win 10#Run XFCE terminal#Start the terminal)
        - [Create useful shortcuts](#linux terminal on win 10#Create useful shortcuts)
            - [VcXsrv configuration file shortcut](#linux terminal on win 10#Create useful shortcuts#VcXsrv configuration file shortcut)
            - [XFCE terminal shortcut](#linux terminal on win 10#Create useful shortcuts#XFCE terminal shortcut)
        - [Tips & Tricks](#linux terminal on win 10#Tips & Tricks)

# disk
## repair
__NEVER__ run `defragment disk` before `chkdsk` if there are performance issues.

### chkdsk
serves to check and repair wrong sectors on a disk formatted as __FAT32__ or __NTFS__
ran from `cmd.exe`

to run `chkdsk` on other disk than `c:`:
```bat
chkdsk f: /f /r /x
```

command: chkdsk [volume - c:] flags
for help use `chkdsk /?`

some flags:
`/?` - shows help
`/f` - fix errors on disk
`/r` - find and repair bad sectors, restore readable data, implies `/f`
`/x` - unmount the disk if necesarry, chkdsk then runs on the disk without anything locking or accessing its data, implies `/f`

# linux terminal on win 10
From: https://timvisee.com/blog/fix-windows-terminals-use-linux-terminal/

## Windows Subsystem for Linux Installation
From: https://docs.microsoft.com/en-us/windows/wsl/install-win10

1) Enable the Windows Subsystem for Linux
As __admin__:
```PowerShell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

2) Update to WSL 2
To update to `WSL 2`, you must be running Windows 10.
_Requirements_:
  - For x64 systems: Version 1903 or higher, with Build 18362 or higher.
  - For ARM64 systems: Version 2004 or higher, with Build 19041 or higher.
  - Builds lower than 18362 do not support `WSL 2`. Use the
    [[https://www.microsoft.com/software-download/windows10|Windows Update Assistant]]
    to update your version of Windows.
To check your version and build number, select Windows logo key + R, type
winver, select OK. (Or enter the ver command in Windows Command Prompt). Update
to the latest Windows version in the Settings menu.

    _Note_:
    If you are running Windows 10 version 1903 or 1909, open "Settings" from
    your Windows menu, navigate to "Update & Security" and select "Check for
    Updates". Your Build number must be 18362.1049+ or 18363.1049+, with the
    minor build # over .1049. Read more: [[https://devblogs.microsoft.com/commandline/wsl-2-support-is-coming-to-windows-10-versions-1903-and-1909/|WSL 2 Support is coming to Windows 10 Versions 1903 and 1909]].
    See the troubleshooting instructions.

3) Enable Virtual Machine feature
Before installing `WSL 2`, you must enable the `Virtual Machine Platform` optional
feature.

Open PowerShell as Administrator and run:
```PowerShell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

__Restart__ your machine to complete the `WSL` install and update to `WSL 2`.

4) Download the Linux kernel update package
Download the latest package:

[[https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi|WSL2 Linux kernel update package for x64 machines]]

    _Note_:

    If you're using an ARM64 machine, please download the ARM64 package
    instead. If you're not sure what kind of machine you have, open Command
    Prompt or PowerShell and enter: `systeminfo | find "System Type"`.

Run the update package downloaded in the previous step. (Double-click to run -
you will be prompted for elevated permissions, select ‘yes’ to approve this
installation.)

Once the installation is complete, move on to the next step - setting `WSL 2` as
your default version when installing new Linux distributions. (Skip this step
if you want your new Linux installs to be set to `WSL 1`).

    _Note_:
    For more information, read the article [[https://devblogs.microsoft.com/commandline/wsl2-will-be-generally-available-in-windows-10-version-2004|changes to updating the WSL2 Linux kernel]],
    available on the [[https://aka.ms/cliblog|Windows Command Line Blog]].

5) Set WSL 2 as your default version
Open PowerShell and run this command to set `WSL 2` as the default version when
installing a new Linux distribution:

```PowerShell
wsl --set-default-version 2
```

    _Note_:
    The update from `WSL 1` to `WSL 2` may take several minutes to complete
    depending on the size of your targeted distribution. If you are running an
    older (legacy) installation of `WSL 1` from Windows 10 Anniversary Update or
    Creators Update, you may encounter an update error. Follow these
    instructions to [[https://docs.microsoft.com/en-us/windows/wsl/install-legacy#uninstallingremoving-the-legacy-distro|uninstall and remove any legacy distributions]].

    If wsl --set-default-version results as an invalid command, enter wsl
    --help. If the --set-default-version is not listed, it means that your OS
    doesn't support it and you need to update to version 1903, Build 18362 or
    higher.
    
    If you see this message after running the command: `WSL 2` requires an update
    to its kernel component. For information please visit
    https://aka.ms/wsl2kernel. You still need to install the MSI Linux kernel
    update package.

6) Install your Linux distribution of choice
Open the Microsoft Store and select your favorite Linux distribution.

The following links will open the Microsoft store page for each distribution:

- [[https://www.microsoft.com/store/apps/9pjn388hp8c9|Ubuntu 16.04 LTS]]
- [[https://www.microsoft.com/store/apps/9N9TNGVNDL3Q|Ubuntu 18.04 LTS]]
- [[https://www.microsoft.com/store/apps/9n6svws3rx71|Ubuntu 20.04 LTS]]
- [[https://www.microsoft.com/store/apps/9NJFZK00FGKV|openSUSE Leap 15.1]]
- [[https://www.microsoft.com/store/apps/9MZ3D1TRP8T1|SUSE Linux Enterprise Server 12 SP5]]
- [[https://www.microsoft.com/store/apps/9PN498VPMF3Z|SUSE Linux Enterprise Server 15 SP1]]
- [[https://www.microsoft.com/store/apps/9PKR34TNCV07|Kali Linux]]
- [[https://www.microsoft.com/store/apps/9MSVKQC78PK6|Debian GNU/Linux]]
- [[https://www.microsoft.com/store/apps/9n6gdm4k2hnc|Fedora Remix for WSL]]
- [[https://www.microsoft.com/store/apps/9NV1GV1PXZ6P|Pengwin]]
- [[https://www.microsoft.com/store/apps/9N8LP0X93VCP|Pengwin Enterprise]]
- [[https://www.microsoft.com/store/apps/9p804crf0395|Alpine WSL]]

From the distribution's page, select "Get". The first time you launch a newly
installed Linux distribution, a console window will open and you'll be asked to
wait for a minute or two for files to de-compress and be stored on your PC. All
future launches should take less than a second.

You will then need to create a user account and password for your new Linux
distribution.

## Set your distribution version to WSL 1 or WSL 2
From: https://docs.microsoft.com/en-us/windows/wsl/install-win10

You can check the `WSL` version assigned to each of the Linux distributions you
have installed by opening the PowerShell command line and entering the command
(only available in Windows Build 18362 or higher): `wsl -l -v`

```PowerShell
wsl --list --verbose
```

To set a distribution to be backed by either version of `WSL` please run:

```PowerShell
wsl --set-version <distribution name> <versionNumber>
```

Make sure to replace <distribution name> with the actual name of your
distribution and <versionNumber> with the number '1' or '2'. You can change
back to `WSL 1` at anytime by running the same command as above but replacing the
'2' with a '1'.

Additionally, if you want to make `WSL 2` your default architecture you can do so
with this command:

```PowerShell
wsl --set-default-version 2
```

This will set the version of any new distribution installed to `WSL 2`.

## Install XFCE terminal
From: https://timvisee.com/blog/fix-windows-terminals-use-linux-terminal/

Now you can pick a Linux terminal you want to use. We'll be using the terminal
included with the [[https://xfce.org/|XFCE]] desktop in this guide. It's a excellent versatile
terminal, that is efficient, has superb color scheme support, and has all the
options you need. Choosing some different you have experience with is fine as
well, of course.

To __install XFCE__ terminal, we'll use the Ubuntu package manager. Open the start
menu, and search for `bash`. This should bring up a terminal window running Linux
through `WSL` with a `bash` shell. Invoke the following two commands:

```bash
sudo apt update && sudo apt install xfce4-terminal
```

You won't be able to use the installed terminal just yet, because Linux in `WSL`
has no way to draw a window on your screen at this time. We'll fix that in the
next step.

## install X server
From: https://timvisee.com/blog/fix-windows-terminals-use-linux-terminal/

Graphical Linux systems commonly use the [[https://en.wikipedia.org/wiki/X_Window_System|X]] Window System (a.k.a. X11), used to
manage and draw application windows on the screen. This system is very flexible
& modular, which comes to good use in our case. X has various server
implementations, not just for Linux but also for Windows, acting as a system
for rendering windows.

Random fun fact: you can even draw windows over the network with X, to an
external machine.

We need to __install an X server__ on our Windows system and tell Linux in `WSL` to
draw application windows to it. Guess what, this is the last installation step
required for showing the terminal window!

In this guide, we'll be using [[https://sourceforge.net/projects/vcxsrv/|VcXsrv]], but other implementations should work
similarly. Visit its project page, download and install it:
[[https://sourceforge.net/projects/vcxsrv/|sourceforge.net/projects/vcxsrv]]

## Run XFCE terminal
From: https://timvisee.com/blog/fix-windows-terminals-use-linux-terminal/

Now comes the fun part: actually starting and using the terminal.

You must start the X server we installed, tell applications in Linux to draw to
it, and the terminal is ready to start. Note that this is required after each
login.

### Start VcXsrv
First, start the VcXsrv server we have installed. An icon should have appeared
on your desktop, or you might find it through the start menu (named 'Xlaunch').
It will then ask us for some settings through a wizard:

Pick __'Multiple windows'__ for now, you can experiment with other options
later. Leave the __'Display number'__ value at -1.

Just __'Start no client'__ for now, which allows us to show any number of Linux
application windows. You can always start the terminal directly through here at
a later time.

We want to __sync the clipboard__ to make life easier. Also check 
__'Native opengl'__ option.

Click __'Next'__ one more time and start the server.

### Configure X server address
After that, the X server starts and a taskbar tray icon should appear. This is
useful because it tells us the address the server is running at. Right-clicking
allows you to kill the server as well.

Our X server is running at `0.0`, chosen by the server because we set the
display number to `-1`. We need the number before the `.`, being `0` in this case,
and have to configure this in the __Linux environment__.

Open a `bash` shell again through the Windows start menu to access the Linux
environment. And set the `DISPLAY` environment variable to `:0`, for our X server
address:

```bash
export DISPLAY=:0
```

### Start the terminal
This finally makes your system ready to actually start the terminal.
__Invoke the following command__ and see the magic happen:

```bash
xfce4-terminal
```

Oh yes! There it is, the XFCE Linux terminal on your Windows system in all its
glory. The terminal has sane defaults, but I recommend to take a quick look
through its settings anyway to pick the desired color scheme.

Your terminal is now ready to use to its full potential. Happy hacking!

## Create useful shortcuts
Okay, we're not quite done yet.

As you might have noticed, these last few steps are required after each login,
which is cumbersome. The X server must be started, and you need to set the
`DISPLAY` variable for each `bash` shell you open from Windows. Though the
following steps are not required, it is highly recommended you follow them.

### VcXsrv configuration file shortcut
It is possible to create a configuration file for VcXsrv, to instantly start
the server without going through the wizard again and again.

To do this, go through the wizard one last time. You might want to use `0` as
__'Display number'__ (instead of `-1`) to ensure you're always starting the server on
a consistent address. On the final wizard screen, a __'Save configuration'__ button
appears, click it and save it in an easy-to-access place such as your desktop
as it will act as shortcut.

Double-clicking the created configuration file/shortcut should start the
server, and a tray icon should appear.

### XFCE terminal shortcut
We can make starting the terminal easier by creating a custom shortcut.
Right-click on your desktop or an Explorer window to create a new shortcut:

We'll start `bash`, and automatically invoke the commands we ran before. Fill in
the following command in the __'Location'__ field for this shortcut:

```
bash -c 'export DISPLAY=:0; xfce4-terminal -e bash'
```

Hit __'Next'__, pick a fun name and you're done.

Double-clicking the shortcut you've created should automatically open a new
proper terminal window. Hurray!

Windows automatically spawns a window for the `bash` command we're running
through the shortcut, causing two windows to show up. This is annoying. Luckily
we can minimize this unused window by default. Right-click on the shortcut, and
hit __'Properties'__. Set the __'Run'__ option to __'Minimized'__.

Not showing the bash window at all is also possible with a workaround, but
won't be covered in this guide.

## Tips & Tricks
Here are some tips, tricks, and notices you might find useful.

You can extend the command used for the shortcut to automatically open a
specific Linux program or to start an `ssh` session. You can create multiple
different shortcuts as well. Here's an example to immediately start a `ssh`
session I commonly use:

```
bash -c 'export DISPLAY=:0; xfce4-terminal -e "bash -c \"ssh root@work.lan\""'
```

You can set the DISPLAY environment variable by default, by appending the
export `DISPLAY=:0` line to the `~/.bashrc` file through your `bash` shell.

You can use other graphical Linux software as well after setting the `DISPLAY`
environment variable.

If Linux applications don't show up, and the shortcut immediately quits, you
have probably configured an incorrect X server address or did not configure it
at all. Review the Configure X server address section.


[back to index](index.md)
