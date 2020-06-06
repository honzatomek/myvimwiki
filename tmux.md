# Contents

- [TMUX](#TMUX)
    - [BASIC KEYBINDS](#TMUX#BASIC KEYBINDS)
        - [LEADER](#TMUX#BASIC KEYBINDS#LEADER)
    - [CUSTOM SETUP](#TMUX#CUSTOM SETUP)
        - [256 color support](#TMUX#CUSTOM SETUP#256 color support)
        - [default command language](#TMUX#CUSTOM SETUP#default command language)
        - [status bar colors](#TMUX#CUSTOM SETUP#status bar colors)
        - [highight and display](#TMUX#CUSTOM SETUP#highight and display)
        - [start window numbering at 1 instead of 0](#TMUX#CUSTOM SETUP#start window numbering at 1 instead of 0)
        - [start pane numbering at 1 instead if 0](#TMUX#CUSTOM SETUP#start pane numbering at 1 instead if 0)
        - [bind h to hortizontal split panes](#TMUX#CUSTOM SETUP#bind h to hortizontal split panes)
        - [bind v to vertical split panes](#TMUX#CUSTOM SETUP#bind v to vertical split panes)

# TMUX
Terminal Multiplexer

File with personal configuration settings: [[local:~/.tmux.conf]]

## BASIC KEYBINDS
### LEADER
tmux may be controlled from an attached client by using a key combination of a prefix key, ‘C-b’ (Ctrl-b) by default, followed by a command key.

The default command key bindings are:

| **Binding**     | **Description**                                                                                                            |
|-----------------|----------------------------------------------------------------------------------------------------------------------------|
| C-b             | Send the prefix key (C-b) through to the application.                                                                      |
| C-o             | Rotate the panes in the current window forwards.                                                                           |
| C-z             | Suspend the tmux client.                                                                                                   |
| !               | Break the current pane out of the window.                                                                                  |
| "               | Split the current pane into two, top and bottom.                                                                           |
| #               | List all paste buffers.                                                                                                    |
| $               | Rename the current session.                                                                                                |
| %               | Split the current pane into two, left and right.                                                                           |
| &               | Kill the current window.                                                                                                   |
| '               | Prompt for a window index to select.                                                                                       |
| (               | Switch the attached client to the previous session.                                                                        |
| )               | Switch the attached client to the next session.                                                                            |
| ,               | Rename the current window.                                                                                                 |
| -               | Delete the most recently copied buffer of text.                                                                            |
| .               | Prompt for an index to move the current window.                                                                            |
| 0 to 9          | Select windows 0 to 9.                                                                                                     |
| :               | Enter the tmux command prompt.                                                                                             |
| ;               | Move to the previously active pane.                                                                                        |
| =               | Choose which buffer to paste interactively from a list.                                                                    |
| ?               | List all key bindings.                                                                                                     |
| D               | Choose a client to detach.                                                                                                 |
| L               | Switch the attached client back to the last session.                                                                       |
| [               | Enter copy mode to copy text or view the history.                                                                          |
| ]               | Paste the most recently copied buffer of text.                                                                             |
| c               | Create a new window.                                                                                                       |
| d               | Detach the current client.                                                                                                 |
| f               | Prompt to search for text in open windows.                                                                                 |
| i               | Display some information about the current window.                                                                         |
| l               | Move to the previously selected window.                                                                                    |
| n               | Change to the next window.                                                                                                 |
| o               | Select the next pane in the current window.                                                                                |
| p               | Change to the previous window.                                                                                             |
| q               | Briefly display pane indexes.                                                                                              |
| r               | Force redraw of the attached client.                                                                                       |
| m               | Mark the current pane (see select-pane -m).                                                                                |
| M               | Clear the marked pane.                                                                                                     |
| s               | Select a new session for the attached client interactively.                                                                |
| t               | Show the time.                                                                                                             |
| w               | Choose the current window interactively.                                                                                   |
| x               | Kill the current pane.                                                                                                     |
| z               | Toggle zoom state of the current pane.                                                                                     |
| {               | Swap the current pane with the previous pane.                                                                              |
| }               | Swap the current pane with the next pane.                                                                                  |
| ~               | Show previous messages from tmux, if any.                                                                                  |
| Page Up         | Enter copy mode and scroll one page up.                                                                                    |
| Up, Down        | Change to the pane above, below, to the left, or to the right of the current pane.                                         |
| Left, Right     | Change to the pane above, below, to the left, or to the right of the current pane.                                         |
| M-1 to M-5      | Arrange panes in one of the five preset layouts: even-horizontal, even-vertical, main-horizontal, main-vertical, or tiled. |
| Space           | Arrange the current window in the next preset layout.                                                                      |
| M-n             | Move to the next window with a bell or activity marker.                                                                    |
| M-o             | Rotate the panes in the current window backwards.                                                                          |
| M-p             | Move to the previous window with a bell or activity marker.                                                                |
| C-Up, C-Down    | Resize the current pane in steps of one cell.                                                                              |
| C-Left, C-Right | Resize the current pane in steps of one cell.                                                                              |
| M-Up, M-Down    | Resize the current pane in steps of five cells.                                                                            |
| M-Left, M-Right | Resize the current pane in steps of five cells.                                                                            |

Key bindings may be changed with the bind-key and unbind-key commands.

## CUSTOM SETUP
### 256 color support
one possibility:
```bash
# set 256 color support for tmux
set -g default-terminal "screen-256color"
```

or (this one works - tested);
```bash
# set 256 color support for tmux
set -g default-terminal "tmux-256color"
```

### default command language
```bash
set-option -g default-command bash
```


### status bar colors
```bash
set -g status-bg blue
```

or:
```bash
set -g status-fg black
```

### highight and display
```bash
setw -g monitor-activity on
setw -g visual-activity on
```

### start window numbering at 1 instead of 0
```bash
set -g base-index 1
```

### start pane numbering at 1 instead if 0
```bash
set -g pane-base-index 1
```

### bind h to hortizontal split panes
```bash
unbind '"'
bind h split-window -v
```

### bind v to vertical split panes
```bash
unbind %
bind v split-window -h
```

[back to index](index)
