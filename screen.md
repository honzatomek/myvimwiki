# Contents

- [layout](#layout)
    - [Default layout for new screen's](#layout#Default layout for new screen's)
    - [session with custom .screenrc](#layout#session with custom .screenrc)
        - [example](#layout#session with custom .screenrc#example)
    - [kill all detached sessions](#layout#kill all detached sessions)

# layout
https://superuser.com/questions/687348/how-to-persist-gnu-screen-layout-after-restart

## Default layout for new screen's
* Manage your regions, then execute code inside screen:
    * To save your current layout to file .screen_layout:
```bash
rm -f $HOME/.screen_layout
screen -X layout dump .screen_layout
```
    * To make it auto-loading with layout saving:
```bash
echo source .screen_layout  >> $HOME/.screenrc
echo layout save def >> $HOME/.screenrc
```

* How it works:
    1) You type screen.
    2) Screen reads *$HOME/.screenrc*:
    3) `source .screen_layout` - read and execute commands from _$HOME/.screen_layout_
       Regions now created.
    4) `layout save def` - save current regions as layout to keep it when you detach.

* `layout dump .screen_layout`:
    Dump (append) current layout to file in *$HOME* directory.

* `screen -X command`:
    Run *command* in current screen session (if executed inside).
    Similar to *<ctrl+a>* then *:* command.

* You may also disable copyright notice at startup:
```bash
echo startup_message off >> $HOME/.screenrc
```

* Increase scroll buffer (def. 100):
```bash
echo defscrollback 1000 >> $HOME/.screenrc
```

* Write own *.screen_layout* (50% / 50% vertical, with 2 shells):
```bash
split -v
screen -t s1

focus
screen -t s2

focus
```

## session with custom .screenrc
creates a new session by ${session_name} and runs custom rc file for it
```bash
screen -S "${session_name}" -c ~/.screenrc_custom
```

can be scripted:
1) create a default .screenrc file
2) create an rc file for each custom predefined session
3) source the default .screenrc file inside
4) create a custom layout file
5) source a layout file inside, don't forget to include `layout save def` at the end of the custom rc file
6) write a script that checks if a session by given name is running:
    * if session is running --> attach
    * if session is not running --> create

screen existing + attach/create example:
```bash
if [[ $(screen -ls | grep "${session_name}") ]] ; then
    screen -x "${session_name}"
else
    screen -S "${session_name}" -c ~/.screenrc_custom
fi
```

### example
* list of files:
```bash
.
├── python3/
│   └── .screenrc_python
├── screenpython*
└── .screenrc

1 directory, 5 files
```

* default **.screenrc**:
```bash
startup_message off
defscrollback 1000

shell /bin/bash
```

* custom **./python3/.screenrc_python**:
```bash
source .screenrc

split -v
resize 60%
screen -t 'edit' -X bash -c "cd ${HOME}/Programming/PYTHON3/bin/; vim"

focus
screen -t 'repl' -X /usr/bin/env python3

focus

layout save def
```

* script to **start** or **attach to** a **named session**:
```bash
#!/bin/bash

SCRIPT=$(readlink -m "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
SCREENRC=".screenrc"
SESSIONRC=".screenrc_python"
SESSIONLAYOUT=".screen_python_layout"
SESSION='python3'

if [[ ! -e "${HOME}/${SCREENRC}" ]] ; then
  echo -e "[\033[01;31e-\033[0m] - ${SCREENRC} missing in ${HOME}"
  echo -e "[\033[01;33ei\033[0m] - copying generic ${SCREENRC} to ${HOME}"
  cp "${SCRIPTPATH}/${SCREENRC}" "${HOME}/${SCREENRC}"
else
  echo -e "[\033[01;32e+\033[0m] - ${SCREENRC} found in ${HOME}"
fi

if [[ $(screen -ls | grep "${SESSION}") ]] ; then
  screen -x "${SESSION}"
else
  screen -S "${SESSION}" -c "${SCRIPTPATH}/${SESSION}/${SESSIONRC}"
fi
```


## kill all detached sessions
```bash
#!/bin/bash

screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
```

[back to index](index.md)
