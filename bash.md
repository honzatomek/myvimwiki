# Contents

- [SED](#SED)
    - [replace file](#SED#replace file)
    - [replace all occurences](#SED#replace all occurences)
    - [extended regexp](#SED#extended regexp)
    - [prefilter lines for regexp](#SED#prefilter lines for regexp)
    - [command inside replace space](#SED#command inside replace space)
    - [REGEXP](#SED#REGEXP)
    - [Examples](#SED#Examples)
    - [character classes](#SED#character classes)
- [AWK](#AWK)
    - [match, group, substitute and if-else example](#AWK#match, group, substitute and if-else example)
    - [act only on matching lines](#AWK#act only on matching lines)
    - [act on all lines](#AWK#act on all lines)
    - [example](#AWK#example)
    - [floating point operations using GNU AWK](#AWK#floating point operations using GNU AWK)
- [GREP](#GREP)
    - [print only matched string](#GREP#print only matched string)
    - [print nonmatched lines](#GREP#print nonmatched lines)
- [useful commands](#useful commands)
    - [cat](#useful commands#cat)
    - [cut](#useful commands#cut)
    - [find](#useful commands#find)
    - [fuser](#useful commands#fuser)
    - [grep](#useful commands#grep)
    - [head](#useful commands#head)
    - [ln -s](#useful commands#ln -s)
    - [readlink](#useful commands#readlink)
    - [sed](#useful commands#sed)
    - [tail](#useful commands#tail)
    - [top, htop](#useful commands#top, htop)
    - [xrandr](#useful commands#xrandr)
- [wait for process to finish](#wait for process to finish)
- [check if "*.txt" file exists in dir](#check if "*.txt" file exists in dir)
- [wget](#wget)
    - [recursively download whole structure](#wget#recursively download whole structure)
- [heredoc string](#heredoc string)
    - [multiple heredocs](#heredoc string#multiple heredocs)
    - [redirection to file](#heredoc string#redirection to file)
    - [pipe to command](#heredoc string#pipe to command)
- [function to open multiple files in vim](#function to open multiple files in vim)
- [screen automation function](#screen automation function)
- [c style for loop](#c style for loop)
- [redirect command output to multiple files](#redirect command output to multiple files)
- [redirect command output to multiple commands](#redirect command output to multiple commands)
- [git status in prompt](#git status in prompt)
- [read command output to array](#read command output to array)
- [unique sort array](#unique sort array)

# SED
## replace file
done with `-i` option, only for **GNU SED**
`sed -i 's/pattern/replace/' file`

a file extension for the overwritten file can be specified:
`sed -i.bak 's/pattern/replace/' file`

using temp file
`sed 's/pattern/replace/' file > tmp.bak; mv tmp.bak file`

## replace all occurences
done with `g` flag
`sed 's/pattern/replace/g' file`

## extended regexp
done with either `-E` or `-r` option
`sed -E 's/pattern/replace/' file`

## prefilter lines for regexp
`sed '/pattern/s/pattern/replace/' file`

## command inside replace space
`sed -r 's/(.*CAST[^\x27]*\x27)([^\x27]*)(\x27 AS DateTime.*)/echo "\1"$(date -d"\2" "+%s")"\3"/ge' file`


## REGEXP
FROM: https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html

To know how to use sed, people should understand regular expressions (regexp for short). A regular expression is a pattern that is matched against a subject string from left to right. Most characters are ordinary: they stand for themselves in a pattern, and match the corresponding characters in the subject. As a trivial example, the pattern

    `The quick brown fox`

matches a portion of a subject string that is identical to itself. The power of regular expressions comes from the ability to include alternatives and repetitions in the pattern. These are encoded in the pattern by the use of special characters, which do not stand for themselves but instead are interpreted in some special way. Here is a brief description of regular expression syntax as used in sed.

`char`
A single ordinary character matches itself.

`*`

Matches a sequence of zero or more instances of matches for the preceding regular expression, which must be an ordinary character, a special character preceded by `\`, a `.`, a grouped regexp (see below), or a bracket expression. As a GNU extension, a postfixed regular expression can also be followed by `*`; for example, `a**` is equivalent to `a*`. POSIX 1003.1-2001 says that `*` stands for itself when it appears at the start of a regular expression or subexpression, but many nonGNU implementations do not support this and portable scripts should instead use `\*` in these contexts.

`\+`

As `*`, but matches one or more. It is a GNU extension.

`\?`

As `*`, but only matches zero or one. It is a GNU extension.

`\{i\}`

As `*`, but matches exactly i sequences (i is a decimal integer; for portability, keep it between 0 and 255 inclusive).

`\{i,j\}`

Matches between i and j, inclusive, sequences.

`\{i,\}`

Matches more than or equal to i sequences.

`\(regexp\)`

Groups the inner regexp as a whole, this is used to:
Apply postfix operators, like `\(abcd\)*`: this will search for zero or more whole sequences of ‘abcd’, while `abcd*` would search for ‘abc’ followed by zero or more occurrences of ‘d’. Note that support for `\(abcd\)*` is required by POSIX 1003.1-2001, but many non-GNU implementations do not support it and hence it is not universally portable.
Use back references (see below).

`.`

Matches any character, including newline.

`^`

Matches the null string at beginning of the pattern space, i.e. what appears after the circumflex must appear at the beginning of the pattern space.
In most scripts, pattern space is initialized to the content of each line (see How sed works). So, it is a useful simplification to think of `^#include` as matching only lines where ‘#include’ is the first thing on line—if there are spaces before, for example, the match fails. This simplification is valid as long as the original content of pattern space is not modified, for example with an s command.

> `^` acts as a special character only at the beginning of the regular expression or subexpression (that is, after `\(` or `\|)`. Portable scripts should avoid `^` at the beginning of a subexpression, though, as POSIX allows implementations that treat `^` as an ordinary character in that context.

`$`

It is the same as `^`, but refers to end of pattern space. `$` also acts as a special character only at the end of the regular expression or subexpression (that is, before `\)` or `\|`), and its use at the end of a subexpression is not portable.

`[list]` `[^list]`

Matches any single character in list: for example, `[aeiou]` matches all vowels. A list may include sequences like char1-char2, which matches any character between (inclusive) char1 and char2.
A leading `^` reverses the meaning of list, so that it matches any single character not in list. To include ] in the list, make it the first character (after the `^` if needed), to include - in the list, make it the first or last; to include `^` put it after the first character.

The characters `$`, `*`, `.`, `[`, and `\` are normally not special within list. For example, `[\*]` matches either `‘\’` or `‘*’`, because the `\` is not special here. However, strings like `[.ch.]`, `[=a=]`, and `[:space:]` are special within list and represent collating symbols, equivalence classes, and character classes, respectively, and `[` is therefore special within list when it is followed by `.`, `=`, or `:`. Also, when not in **POSIXLY_CORRECT** mode, special escapes like `\n` and `\t` are recognized within list. See Escapes.


`regexp1\|regexp2`

Matches either regexp1 or regexp2. Use parentheses to use complex alternative regular expressions. The matching process tries each alternative in turn, from left to right, and the first one that succeeds is used. It is a GNU extension.

`regexp1regexp2`

Matches the concatenation of regexp1 and regexp2. Concatenation binds more tightly than `\|`, `^`, and `$`, but less tightly than the other regular expression operators.

`\digit`

Matches the digit-th `\(...\)` parenthesized subexpression in the regular expression. This is called a back reference. Subexpressions are implicity numbered by counting occurrences of `\(` left-to-right.

`\n`

Matches the newline character.

`\char`

Matches char, where char is one of `$`, `*`, `.`, `[`, `\`, or `^`. Note that the only C-like backslash sequences that you can portably assume to be interpreted are `\n` and `\\`; in particular `\t` is not portable, and matches a ‘t’ under most implementations of sed, rather than a tab character.
Note that the regular expression matcher is greedy, i.e., matches are attempted from left to right and, if two or more matches are possible starting at the same character, it selects the longest.

## Examples

`‘abcdef’`
    Matches ‘abcdef’.

`‘a*b’`
    Matches zero or more ‘a’s followed by a single ‘b’. For example, ‘b’ or ‘aaaaab’.

`‘a\?b’`
    Matches ‘b’ or ‘ab’.

`‘a\+b\+’`
    Matches one or more ‘a’s followed by one or more ‘b’s: ‘ab’ is the shortest possible match, but other examples are ‘aaaab’ or ‘abbbbb’ or ‘aaaaaabbbbbbb’.

`‘.*’`
`‘.\+’`
    These two both match all the characters in a string; however, the first matches every string (including the empty string), while the second matches only strings containing at least one character.

`‘^main.*(.*)’`
    This matches a string starting with ‘main’, followed by an opening and closing parenthesis. The ‘n’, ‘(’ and ‘)’ need not be adjacent.

`‘^#’`
    This matches a string beginning with ‘#’.

`‘\\$’`
    This matches a string ending with a single backslash. The regexp contains two backslashes for escaping.

`‘\$’`
    Instead, this matches a string consisting of a single dollar sign, because it is escaped.

`‘[a-zA-Z0-9]’`
    In the C locale, this matches any ASCII letters or digits.

`‘[^ tab]\+’`
    (Here tab stands for a single tab character.) This matches a string of one or more characters, none of which is a space or a tab. Usually this means a word.

`‘^\(.*\)\n\1$’`
    This matches a string consisting of two equal substrings separated by a newline.

`‘.\{9\}A$’`
    This matches nine characters followed by an ‘A’.

`‘^.\{15\}A’`
    This matches the start of a string that contains 16 characters, the last of which is an ‘A’.

## character classes
From: https://www.gnu.org/software/sed/manual/html_node/Character-Classes-and-Bracket-Expressions.html

__!!! beware, the character class needs to be enclosed in `[` `]` brackets => correct is `[[:digit:]]` even for extended regex !!!__

`[:alnum:]`
Alphanumeric characters: `[:alpha:]` and `[:digit:]`; in the `C` locale and ASCII character encoding, this is the same as `[0-9A-Za-z]`.

`[:alpha:]`
Alphabetic characters: `[:lower:]` and `[:upper:]`; in the `C` locale and ASCII character encoding, this is the same as `[A-Za-z]`.

`[:blank:]`
Blank characters: space and tab.

`[:cntrl:]`
Control characters. In ASCII, these characters have octal codes 000 through 037, and 177 (DEL). In other character sets, these are the equivalent characters, if any.

`[:digit:]`
Digits: 0 1 2 3 4 5 6 7 8 9.

`[:graph:]`
Graphical characters: `[:alnum:]` and `[:punct:]`.

`[:lower:]`
Lower-case letters; in the `C` locale and ASCII character encoding, this is a b c d e f g h i j k l m n o p q r s t u v w x y z.

`[:print:]`
Printable characters: `[:alnum:]`, `[:punct:]`, and space.

`[:punct:]`
Punctuation characters; in the `C` locale and ASCII character encoding, this is ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ \` { | } ~.

`[:space:]`
Space characters: in the `C` locale, this is tab, newline, vertical tab, form feed, carriage return, and space.

`[:upper:]`
Upper-case letters: in the `C` locale and ASCII character encoding, this is A B C D E F G H I J K L M N O P Q R S T U V W X Y Z.

`[:xdigit:]`
Hexadecimal digits: 0 1 2 3 4 5 6 7 8 9 A B C D E F a b c d e f.

Note that the brackets in these class names are part of the symbolic names, and must be included in addition to the brackets delimiting the bracket expression.

Most meta-characters lose their special meaning inside bracket expressions:

`]`
ends the bracket expression if it’s not the first list item. So, if you want to make the `]` character a list item, you must put it first.

`-`
represents the range if it’s not first or last in a list or the ending point of a range.

`^`
represents the characters not in the list. If you want to make the `^` character a list item, place it anywhere but first.

The characters `$`, `*`, `.`, `[`, and `\` are normally not special within list. For example, `[\*]` matches either `\` or `*`, because the `\` is not special here. However, strings like `[.ch.]`, `[=a=]`, and `[:space:]` are special within list and represent collating symbols, equivalence classes, and character classes, respectively, and `[` is therefore special within list when it is followed by `.`, `=`, or `:`. Also, when not in POSIXLY_CORRECT mode, special escapes like `\n` and `\t` are recognized within list. See Escapes.

`[.`
represents the open collating symbol.

`.]`
represents the close collating symbol.

`[=`
represents the open equivalence class.

`=]`
represents the close equivalence class.

`[:`
represents the open character class symbol, and should be followed by a valid character class name.

`:]`
represents the close character class symbol.


# AWK
## match, group, substitute and if-else example
had to install GNU AWK (`gawk`), Raspbian is preinstalled with `mawk`:

```bash
GNU Awk 4.2.1, API: 2.0 (GNU MPFR 4.0.2, GNU MP 6.1.2)
Copyright (C) 1989, 1991-2018 Free Software Foundation.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.
```

oneliner:
```bash
#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
#   cat "${f}" | awk 'match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr) { gsub(/ /, "%20", arr[2]); gsub(/\.html$/, "", arr[2]); gsub(/\.md/, "", arr[2]); print arr[1] arr[2] arr[3] }'
  cat "${f}" | awk '{ match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr); if (arr[2] == "") print $0; else { gsub(/ /, "%20", arr[2]); gsub(/\.html$/, "", arr[2]); gsub(/\.md/, "", arr[2]); print arr[1] arr[2] arr[3] }; }'
done
```

much nicer format:
```bash
#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
#   cat "${f}" | awk 'match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr) { gsub(/ /, "%20", arr[2]); gsub(/\.html$/, "", arr[2]); gsub(/\.md/, "", arr[2]); print arr[1] arr[2] arr[3] }'
  cat "${f}" | awk '
  {
    match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr);
    if (arr[2] == "")
      print $0;
    else
      {
        gsub(/ /, "%20", arr[2]);
        gsub(/\.html$/, "", arr[2]);
        gsub(/\.md/, "", arr[2]);
        print arr[1] arr[2] arr[3] };
      }' # > "${f}"
done
```

## act only on matching lines
the match command stores groups (if used)  into the arr list variable
`$0` is the whole line
```bash
cat $file | awk 'match($0, /(pattern1)(pattern2)/, arr)
{
  print arr[1];
  print arr[2];
}
```

## act on all lines
the match command stores groups (if used)  into the arr list variable
`$0` is the whole line
```bash
cat $file | awk '
{
  match($0, /(pattern1)(pattern2)/, arr);
  if (arr[1] != "")
    print arr[1];
    print arr[2];
  else
    print $0;
}
```

## example
```bash
#!/usr/bin/zsh
TmaxC=652
BDF=$1                                                                                   # read first argument into BDF variable
awk -F, 'BEGIN {min=1000;max=0}                                                          # column delimiter = "," (-F option); set min variable to 1000, max variable to 0
         { max=($4>max?$4:max)                                                           # if 4th column is larger than max set max to 4th column, otherwise max = max
           if ($4>0) min=($4<min?$4:min)                                                 # where 4th column is larger than 0; if 4th column is smaller than min then min=4th column value, otherwise min = min
         }
         END { print min,max,min-273.15,max-273.15}' $BDF | read min max minc maxc       # print the resulting values into variables: min = minimal 4th column value, max = maximal 4th column value, dtto in Celsius

echo Ziel-Tmax: ${TmaxC}°C
     Tmin: ${minc}°C
       ax     ax

awk -F, '! /TEMP/ {print $0}                                                             # set the delimiter to ",", if row does not contain TEMP print the row unchanged
           /TEMP/ {                                                                      # for rows that contain TEMP:
                tk='$min'+($4-'$min')/('$max'-'$min')*(('$TmaxC'+273.15)-'$min')         # tk = min + (value - min) / (max - min) * ((TmaxC + 273.15) - min)
                 c      c'+(($4-273.15)-'$minc )/('$maxc -'$minc')*('$TmaxC'-'$minc')    #  c = minc + ((value - 273.15) - minc) / (maxc - minc) * (TmaxC - minc)
                if ( $4 > 0 ) $4 = tk                                                    # if value > 0 then value = tk
                printf ("%s,%s,%s,%12.6e",$1,$2,$3,$4)                                   # print values delimited by "," 1st to 4th column respectively
                if (NF==5) printf (",%s\n",$5)                                           # if NF = number of fields = 5, print the 5th one and newline
                else                \n") }' $BDF > Shift_$BDF                            # else print just newline and export to Shift_$BDF
```

## floating point operations using GNU AWK
```bash
awk "BEGIN {print 100/3}"
```

```bash
awk "BEGIN {printf \"%.2f\n\", 100/3}"
```

```bash
awk "BEGIN {print -8.4 - -8}"
```

# GREP
## print only matched string
`grep -Eo 'pattern' file`

> `-E` means extended regexp
> `-o` means only matching string

## print nonmatched lines
`grep -Ev 'pattern' file`

> `-E` means extended regexp
> `-v` means inVersed match


# useful commands
## cat
concatenate all files matching to a single file:
`cat *.pro >> profiles.txt`

## cut
cut delimited string (`-d`) and select 4th field (`-f`):
`xrandr | grep -v 'DVI\|DP\|Screen' | cut -d ' ' -f 4`

## find
finds all files that satisfy `-name` expression in all subfolder levels limited by `-maxdepth` and `-mindepth` (`-type = file`):

```bash
find . -maxdepth 1 -mindepth 1 -type f -name "*.png"
```

```bash
find . -mindepth 1 -mtime +60 -type f -name "*.bif" -exec du '{}' \; >> found_files_log
```

total size of found files:
```bash
find . -mindepth 1 -mtime +60 -type f -name "*.bif" -exec du -ch '{}' + | grep total$
```

## fuser
gets user of a temporary .nfs file:
`fuser .nfs0000000000005eb80000172e`

## grep
grep multiple strings from file and export them to another:
`grep -E 'one|two' file.txt >another_file.txt`
`grep 'one\|two' file.txt >another_file.txt`
get matching line number:
`xrandr | grep -n 'DVI-I-1' | cut -d : -f 1`

## head
get first five lines:
`head -n 5 ./opt??/*.pro`

## ln -s
create symbolic link to a file or directory:
`ln -s /proj/P1144/permas/rechnungen/ ./rechnungen`

## readlink
writes real path of a symbolic link:
`readlink -f "filename"`
`readlink -f "directory"`

## sed
replace $CONTACT STATUS LPAT=360 with $CONTACT STATUS LPAT=5 in file statik_kompass_360.caso and export result to out:
`sed -e 's/$CONTACT STATUS LPAT=360/$CONTACT STATUS LPAT=5/' statik_kompass_360.caso > out`
get common prefix of all matching files:
`printf "%s\n" $(find . -maxdepth 1 -mindepth 1 -type f -name "*.png") | sed -e '$!{N;s/^\(.*\).*\n\1.*$/\1\n\1/;D;}'`

## tail
get last 5 lines, redirect them and use grep to export lines with Elapsed to elapsed.txt:
`tail -n 5 ./opt??/*.pro >output.txt ; grep Elapsed output.txt >elapsed.txt`
`tail -n 5 ./opt??/*.pro | grep Elapsed >elapsed.txt`
get last 5 lines, redirect to grep and search for two words:
`tail -n 5 ./_staangle???/*.pro | grep '_staangle\|Elapsed'`

## top, htop
get current running processes:
`top`
`htop`

## xrandr
get all available screen resolutions:
`xrandr`
set screen resolution to 1920x1200:
`xrandr -s 1920x1200`
list available screen resolutions (`-v` means show lines not matching):
`xrandr | grep -v 'DVI\|DP\|Screen'`
list only available screen resolutions:
`xrandr | grep -v 'DVI\|DP\|Screen' | cut -d ' ' -f 4`

# wait for process to finish
run a cmd in background, using `$!` get its PID and supply it to `wait` command to wait for the process to finish:
```bash
CMD="cmd"
"${CMD}" &
BACK_PID=$!
echo "Running ${CMD} as ${BACK_PID}"
wait ${BACK_PID}
```

!!! always print the `PID` of the process spawned in the background, `<ctrl-c>` will only kill
the waiting script.

can be used in a loop:
```bash
commands=("command1" "command2" "command3")
for cmd in "${commands[@]}"; do
    "${cmd}" &
    BACK_PID=$!
    echo "Running ${cmd} as ${BACK_PID}"
    wait ${BACK_PID}
done
echo "Done."
```

# check if "*.txt" file exists in dir
the test is done using `find` command
```bash
res="$(find . -maxdepth 1 -name '*.txt' -type f -print -quit)"
if [ -n "${res}" ]; then # -n tests if string is not null
    echo "*.txt file exists"
else
    echo "no *.txt found"
fi

if [ -z "${res}" ]; then # -z tests if string is null
    echo "no *.txt found"
else
    echo "*.txt file exists"
fi
```

# wget
## recursively download whole structure
```bash
wget -r -p -k --wait=1 http://website.html
```
the `--wait=#SECONDS` option is a courtesy to not overwhelm the target website. Sometimes, if the download is too massive,
the website will block subsequent wget calls.
`-r` download recursively
`-p` page requisites - wget will download all files needed to properly display the page
`-k` convert links - convert all links for local viewing

# heredoc string
```bash
cat << EOF
vimsplit function

author:      Jan Tomek <rpi3.tomek@protonmail.com>
date:        24.07.2020
description: function to open multiple files in vim, first n files are opened in vertical splits,
             next n files are opened in vertical splits on new tab and so on.

use:         vimsplit [-n N] file1 file2 file3
optional:    -h|--help     - prints this help and exits
             -n|--number N - number of files in splits per tab, default = 2
positional:  filex         - files to open
EOF
```

## multiple heredocs
```bash
cat <<EOF1; cat <<EOF2
Hello, 
EOF1
there!
EOF2
```

## redirection to file
```bash
cat > file.txt << EOF
vimsplit function

author:      Jan Tomek <rpi3.tomek@protonmail.com>
date:        24.07.2020
description: function to open multiple files in vim, first n files are opened in vertical splits,
             next n files are opened in vertical splits on new tab and so on.

use:         vimsplit [-n N] file1 file2 file3
optional:    -h|--help     - prints this help and exits
             -n|--number N - number of files in splits per tab, default = 2
positional:  filex         - files to open
EOF
```

## pipe to command
```bash
cat << EOF | msmtp -a default 
To: username@domail.com
From: username@domain.com
Subject: this is a subject

This is the mail body.
EOF
```

or
```bash
cat << EOF |
To: username@domail.com
From: username@domain.com
Subject: this is a subject

This is the mail body.
EOF
msmtp -a default 
```

# function to open multiple files in vim
simple solution
```bash
vimsplit () {
  local files=("$1")
  for (( i = 2; i <= "$#"; i++ )); do
    if (( "${i}" & 1 )); then
      files+=("+\"vsplit ${!i}\"")
    else
      files+=("+\"tabnew ${!i}\"")
    fi
  done

  set -- "${files[@]}"
  echo "vim $@"
  eval vim "$@"
}
```

more sophisticated
```bash
vimsplit () {
  local files=()
  local n=2
  local s="v"
  local t=1
  while (( "$#" )); do
    case "$1" in
      -n|--number)
        if [[ $2 =~ ^[1-9]$ ]]; then
          n="$2"
          shift 2
        else
          shift
        fi
        ;;
      -s|--hsplit)
        s=""
        shift
        ;;
      -t|--notabs)
        t=0
        shift
        ;;
      -h|--help|-*|--*)
      cat << EOF
vimsplit [-h] [-s] [-t] [-n N] file1 [ file2  [ file3 [ ... ] ] ]

author:      Jan Tomek <rpi3.tomek@protonmail.com>
date:        24.07.2020
description: function to open multiple files in vim, first n files are opened in vertical splits,
             next n files are opened in vertical splits on new tab and so on.

optional:    -h|--help     - prints this help and exits
             -s|--hsplit   - opens the files in horizontal splits
             -t|--notabs   - does not open new tabs, all files are in one window
             -n|--number N - number of files in splits per tab, default = 2
positional:  filex         - files to open
EOF
        return 1
        ;;
      -*|--*)
        echo "[-] Unsupported argument $1, read --help"
        return 2
        ;;
      *)
        if [ -f "$1" ]; then files+=("$1"); fi
        shift
        ;;
    esac
  done

  if (( "${t}" )); then
    for (( i = 1; i < "${#files[@]}"; i++ )) ; do
      if [ $(("${i}" % "${n}")) -eq 0 ] ; then
        files["${i}"]="+\"tabnew ${files[${i}]}\""
      else
        files["${i}"]="+\"${s}split ${files[${i}]}\""
      fi
    done
  else
    for (( i = 1; i < "${#files[@]}"; i++ )) ; do
      files["${i}"]="+\"${s}split ${files[${i}]}\""
    done
  fi

#   echo "vim ${files[@]}"
  eval "vim ${files[@]}"
  return 0
}
```

# screen automation function
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
                                  their order. commands must be single quoted.
                                  each command is ended with a ;.

  REQUIRED:    name               name of the session to create or attach to if exists

  USE:
               - as an alias
                                  alias kilo="myscreen --cmd 'cd ~/Programming/C_CPP/bin/c_kilo/src/' kilo"
               - from CLI
                                  myscreen mov
EOF
        return 1
        ;;
      -c|--cmd)
        COMMANDS="${COMMANDS} $2;"
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

__USAGE EXAMPLE__:
`alias kilo="myscreen --cmd 'cd ~/Programming/C_CPP/bin/c_kilo/src/' --cmd 'vim kilo.c' kilo"`


# c style for loop
`for (( i = 0; i < 100; i++ )); do echo "$i"; done`

iterating over array:
```bash
for (( i=0; i<"${#arr[@]}"; i++ )); do
  echo "${arr[$i]}"
done
```

# redirect command output to multiple files
`stdout` to console and two files:
```bash
cmd | tee file1 file2
```

`stdout` to two files:
```bash
cmd | tee file1 file2 > /dev/null
```

`stdout` and `stderr` to two files:
```bash
cmd 2&>1 | tee file1 file2 > /dev/null
```

# redirect command output to multiple commands
In loop using __temp file__:
```bash
#!/bin/bash

temp=$( mktemp )
cmd0 > "$temp"
cmds=("cmd1" "cmd2")
for cmd in "${cmds[@]}"; do
    eval "${cmd}" < "${temp}"
done
rm "${temp}"
```

using __process substitution__:
```bash
#!/bin/bash

cmd 2&>1 | tee >(cmd1 > cmd1.log) >(cmd2 > cmd2.log) > /dev/null
```

capture output to __variable__:
```bash
#!/bin/bash

cmdout="$(cmd0)"
echo "${cmdout}" | cmd1
echo "${cmdout}" | cmd2
```

create __named pipes__:
```bash
#!/bin/bash

# create temp directory
tmp_dir="$(mktemp -d)"

# create named pipes
mkfifo "${tmp_dir}/f1" "${tmp_dir}/f2"

cmd1 <"${tmp_dir}/f1" & pid1=$!
echo "Running cmd1 as ${pid1}, waiting for input."

cmd2 <"${tmp_dir}/f2" & pid2=$!
echo "Running cmd2 as ${pid2}, waiting for input."

# create the input
tee "${tmp_dir}/f1" "${tmp_dir}/f2" | cmd0

# wait for the processes to finish
wait $pid1 $pid2

# cleanup
rm -rf "${tmp_dir}"
```

maybe this way:
```bash
#!/bin/bash

# create temp directory
tmp_dir="$(mktemp -d)"

# create named pipes
mkfifo "${tmp_dir}/f1" "${tmp_dir}/f2"

# create the input
cmd0 | tee "${tmp_dir}/f1" "${tmp_dir}/f2" >/dev/null

cmd1 <"${tmp_dir}/f1" & pid1=$!
echo "Running cmd1 as ${pid1}"

cmd2 <"${tmp_dir}/f2" & pid2=$!
echo "Running cmd2 as ${pid2}"

# wait for the processes to finish
wait $pid1 $pid2

# cleanup
rm -rf "${tmp_dir}"
```

# git status in prompt
```bash
#!/bin/bash

gitPS1 () {
  local gitps1=$(git branch 2>/dev/null | grep '*')
  if ! git diff --quiet --cached; then
    gitps1="${gitps1:+\[\033[0m\](\[\033[01;35m\]${gitps1/#\* /}*\[\033[0m\])}"
  elif ! git diff --quiet; then
    gitps1="${gitps1:+\[\033[0m\](\[\033[01;31m\]${gitps1/#\* /}+\[\033[0m\])}"
  else
    gitps1="${gitps1:+\[\033[0m\](\[\033[01;32m\]${gitps1/#\* /}\[\033[0m\])}"
  fi
  echo "$gitps1"
}

# Custom prompt colors
update_PS1 () {
  PS1="\[\033[01;34m\]\u\[\033[01;32m\]@\h\[\033[00;37m\]:\[\033[01;34m\]\w\[\033[01;31m\] $(gitPS1)\[\033[01;34m\]\$\[\033[00;37m\] "
}
shopt -u promptvars
PROMPT_COMMAND=update_PS1
```

# read command output to array
```bash
#!/bin/bash

arr=()
while IFS=  read -r -d $'\n'; do
  arr+=("$REPLY")
done < <(echo "${file}" | xargs grep -Eoh "${pattern}")
```

# unique sort array
```bash
#!/bin/bash
arr=("$(echo ${arr} | tr ' ' '\n' | sort -u | tr '\n' ' ')")
```

[back to index](index.md)
