# Contents

- [layout](#layout)
    - [default layout for new screen's](#layout#default layout for new screen's)
    - [session with custom .screenrc](#layout#session with custom .screenrc)
        - [example](#layout#session with custom .screenrc#example)
    - [kill all detached sessions](#layout#kill all detached sessions)
- [bash automation function](#bash automation function)
- [256 color support](#256 color support)
- [statusline](#statusline)

# layout
https://superuser.com/questions/687348/how-to-persist-gnu-screen-layout-after-restart

## default layout for new screen's
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
```screen
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
```screen
startup_message off
defscrollback 1000

shell /bin/bash
```

* custom **./python3/.screenrc_python**:
```screen
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

# bash automation function
```bash
myscreen () {
  local COMMANDS=""
  local SESSION=""

  while (( "$#" )); do
    case "$1" in
      -h|--help)
        echo -e "[\033[01;35m?\033[0m] - myscreen() [-h] [-c command] name"

        cat <<EOF

  AUTHOR:      Jan Tomek <rpi3.tomek@protonmail.com> 27.07.2020
  DESCRIPTION: creates or connects to a screen session
  OPTIONAL:    -h|--help          prints this help and exits
               -c|--cmd command   executes a command when creating a session,
                                  multiple -c arguments possible, commands are sent in
                                  their order.

  REQUIRED:    name               name of the session to create or attach to if exists
EOF
        return 1
        ;;
      -c|--cmd)
        COMMANDS="${COMMANDS}cd $2;"
        shift 2
        ;;
      -*|--*)
        echo -e "[\033[01;31m-\033[0m] - ERROR, unsupported flag $1"
        return 2
        ;;
      *)
        SESSION="$1"
        shift
        ;;
    esac
  done

  if [ -z "${SESSION}" ]; then
    echo -e "[\033[01;31m-\033[0m] - ERROR, no session name supplied, exiting.."
    return 2
  fi

  if ! [[ $(screen -ls | grep "${SESSION}") ]] ; then
    screen -d -m -S "${SESSION}"
    if [ ! -z "${COMMANDS}" ]; then
      screen -S "${SESSION}" -X stuff "${COMMANDS}clear;$(echo -ne '\015')"
    fi
  fi

  screen -x "${SESSION}"
}
```

`-d -m` start a session in __detached__ mode
`-S` name a __session__
`-X stuff` send a command to named session
`$(echo -ne '\015')` send ener charcode
`-x` attach to a named session

# 256 color support
in `.screenrc`:
```screen
# add 256 color support
attrcolor b ".I"
termcapinfo xterm 'Co#256:AB=\E[48;5;%dm:AF=\E38;5;%dm'
defbce "on"
```

in `.bashrc`:
```bash
# this is in addition to export XTERM='xterm-256color'
export TERM='screen-256color'
```

in `.vimrc`:
```vim
set t_Co=256
```

# statusline
From: https://superuser.com/questions/51988/what-is-the-best-gnu-screen-taskbar-youve-used-seen
```screen
hardstatus alwayslastline "%{b kw}%H %{r}%1` %{w}| %{g}%c %{w}| %{y}%d.%m.%Y %{w}| %{g}%l %{w}| %{-b kw}%u %-Lw%{= rW}%50> %n%f %t %{-}%+Lw%<"
```

other possibility:
```screen
add a comment
12
votes
I also use a fairly involved caption/hardstatus line combination, to simulate the effect of dropdown tabs (the caption line is solid grey and the current tab in the hardstatus is the same color).

I also have my shell tell screen what the current process name is and what directory I'm in, so my tab names stay up to date with what I'm doing in each tab. This is critical to remembering what I'm doing where without having to flick through all my open tabs.

 # don't use the hardstatus line for system messages, use reverse video instead
 # (we'll be using it for the list of tab windows - see hardstatus alwayslastline
 # below)
 hardstatus off

 # use the caption line for the computer name, load, hstatus (as set by zsh), & time
 # the caption line gets repeated for each window being displayed (using :split),
 # so we'll use color cues to differentiate the caption of the current, active
 # window, and the others.
 #    always                  - display the caption continuously.  Since
 #                              hardstatus is 'alwayslastline', it will be on the
 #                              next to last line.
 #    "%?%F"                  - if (leading '%?') this region has focus ('%F') 
 #                              (e.g. it's the only region being displayed, or,
 #                              if in split-screen mode, it's the currently active
 #                              region)
 #      "%{= Kk}"               - set the colorscheme to blac[k] on grey (bright blac[K]),
 #                                with no other effects (standout, underline, etc.)
 #    "%:"                    - otherwise ('%:' between a pair of '%?'s)
 #      "%{=u kR}"              - set the colorscheme to [R]ed on blac[k], and
 #                                underline it, but no other effects (bold, standout, etc.) 
 #    "%?"                    - end if (trailing '%?')
 #    "  %h "                 - print two spaces, tthne the [h]ardstatus of the
 #                              current tab window (as set by zsh - see zshrc) and
 #                              then another space.
 #    "%-024="                - either pad (with spaces) or truncate the previous
 #                              text so that the rest of the caption string starts
 #                              24 characters ('024') from the right ('-') edge of
 #                              the caption line.
 #                              NOTE: omitting the '0' before the '24' would pad
 #                              or truncate the text so it would be 24% from the
 #                              right.
 #    "%{+b}                  - add ('+') [b]old to the current text effects, but
 #                              don't change the current colors.
 #    " %C:%s%a %D %d %M %Y"  - print the [C]urrent time, a colon, the [s]econds,
 #                              whether it's [a]m or pm, the [D]ay name, the [d]ay
 #                              of the month, the [M]onth, and the [Y]ear.
 #                              (this takes up 24 characters, so the previous
 #                              pad/truncate command makes sure the clock doesn't
 #                              get pushed off of the caption line)
 #    "%{= dd}"               - revert to the [d]efault background and [d]efault
 #                              foreground colors, respectively, with no ('= ')
 #                              other effects.
 #  other things that might be useful later are
 #    " %H"                   - print a space, then the [H]ostname.
 #    "(%{.K}%l%{-}):"        - print a '(', then change the text color to grey
 #                              (aka bright blac[K]), and print the current system
 #                              [l]oad.  Then revert to the previous colorscheme
 #                              ('%{-}') and print a close ')' and a colon.
 #                              NOTE: the load is only updated when some other
 #                              portion of the caption string needs to be changed
 #                              (like the seconds in the clock, or if there were a
 #                              backtick command)
 #    "%0`"                   - put the output of a backtick command in the line
 #    "%-024<"                - don't pad, just truncate if the string is past 24
 #                              characters from the right edge
 #    "%-="                   - pad (with spaces) the previous text text so that
 #                              the rest of the caption string is justified
 #                              against the right edge of the screen.
 #                              NOTE: doesn't appear to truncate previous text.
 caption always           "%?%F%{= Kk}%:%{=u kR}%?  %h %-024=%{+b} %C%a %D %d %M %Y%{= db}"
 # use the hardstatus line for the window list
 #    alwayslastline      - always display the hardstatus as the last line of the
 #                          terminal
 #    "%{= kR} %-Lw"      - change to a blac[k] background with bright [R]ed text,
 #                          and print all the tab [w]indow numbers and titles in
 #                          the [L]ong format (ie with flags) upto ('-') the
 #                          current tab window
 #    "%{=b Kk} %n%f %t " - change to grey (bright blac[K]) background with
 #                          [b]old blac[k] text, with no other effects, and print
 #                          the [n]umber of the current tab window, any [f]lags it
 #                          might have, and the [t]itle of the current tab window
 #                          (as set by zsh - see zshrc).
 #                          NOTE: the color match with the caption line makes it
 #                          appear as if a 'tab' is dropping down from the caption
 #                          line, highlighting the number & title of the current
 #                          tab window.  Nifty, ain't it)
 #    "%{-}%+Lw "         - revert to the previous color scheme (red on black)
 #                          and print all the tab [w]indow numbers and titles in
 #                          the [L]ong format (ie with flags) after ('+') the
 #                          current tab window.
 #    "%=%{= dd}"         - pad all the way to the right (since there is no text
 #                          that follows this) and revert to the [d]efault
 #                          background and [d]efault foreground colors, with no
 #                          ('= ') other effects.
 hardstatus alwayslastline "%{= kR} %-Lw%{=b Kk} %n%f %t %{-}%+Lw %=%{= dd}"
```


[back to index](index.md)
