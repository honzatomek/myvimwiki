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
    - [replace newlines](#SED#replace newlines)
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
- [interactive script invoking editor and processing results](#interactive script invoking editor and processing results)
- [common prefix](#common prefix)
- [parameter substitution](#parameter substitution)
    - [default value](#parameter substitution#default value)
    - [replace in string](#parameter substitution#replace in string)
    - [substring replacement](#parameter substitution#substring replacement)
- [regex](#regex)

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

## replace newlines
the `-z` flag makes sed work on whole file at once where lines are separated by NUL characters => `\n`
```bash
#!/bin/bash

sed -z -i.bak -e 's/^\s*\n//g' file.in
```
the above example will strip all empty lines from file and create a backup \*.bak file

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

## for loop
From: https://www.gnu.org/software/gawk/manual/html_node/For-Statement.html
From: https://www.gnu.org/software/gawk/manual/html_node/Continue-Statement.html
    for (initialization; condition; increment)
        body

    for (i in array)
        do something with array[i]

```bash
awk '
{
    for (i = 1; i <= 3; i++)
        print $i
}' file
```

```bash
awk '
BEGIN {
     for (x = 0; x <= 20; x++) {
         if (x == 5)
             continue
         printf "%d ", x
     }
     print ""
}' file
```

## while loop
    initialization
    while (condition) {
      body
      increment
    }

```bash
awk '
{
    for (i = 1; i <= 3; i++)
        print $i
}' file
```

```bash
awk '
BEGIN {
     x = 0
     while (x <= 20) {
         if (x == 5)
             continue
         printf "%d ", x
         x++
     }
     print ""
}' file
```

## built-in variables
selected list of awk internal variables
From: https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html

__NF__: number of fields
The number of fields in the current input record. NF is set each time a new record is read, when a new field is created,
or when $0 changes (see section Examining Fields).

Unlike most of the variables described in this subsection, assigning a value to NF has the potential to affect awk’s
internal workings. In particular, assignments to NF can be used to create fields in or remove fields from the current
record. See section Changing the Contents of a Field.

print 1st and last field:
From: https://www.gnu.org/software/gawk/manual/html_node/Fields.html
```bash
awk '
{
print $1, $NF
}' file
```

__FILENAME__: the name of current input file

## access fields programatically
```bash
awk '
{
for ( i = 1; i <= (NF - 1) / 2; i++ )
    print $1, $(i + 1), $(2 * i + 1)
}' file
```

## split file into multiple
From: https://www.theunixschool.com/2012/06/awk-10-examples-to-split-file-into.html
```bash
awk -F, '{if($2<=500)print > "500L.txt";else print > "500G.txt"}' file1
```

## example
```bash
BEGIN {
  pi = atan2(0, -1)
}
{
  num = (NF - 1) / 2
  for ( i = 1; i <= num; i++)
  {
    fname = bname "_" sprintf("%02d", i) ext

    # create header
    if ( FNR == 1 )
    {
      printf "%6s", "Mode" > fname
      for ( x = 0; x <= (2 * pi); x += (2 * pi / 24) )
        printf " %9.1f", x / (2 * pi) * 360 > fname
      printf "\n" > fname
    }

    # calculate and print records
    a = $(1 + i)
    b = $(1 + num + i) / 180 * pi
    printf "%6d", $1 > fname
    for ( x = 0; x <= (2 * pi); x += (2 * pi / 24) )
    {
      printf " %9.4f", a * sin(x + b) > fname
    }
    printf "\n" > fname
  }
}'
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
__grep__ and __sed__
```bash
#!/bin/bash

arr=()
while IFS=  read -r -d $'\n'; do
  arr+=("$REPLY")
done < <(echo "${file}" | xargs grep -Eoh "${pattern}")
```

__find__
```bash
#!/bin/bash

arr=()
while IFS=  read -r -d $'\0'; do
  arr+=("$REPLY")
done < <(find . -type f -name '*.txt' -print0)
```

# unique sort array
```bash
#!/bin/bash
arr=("$(echo ${arr} | tr ' ' '\n' | sort -u | tr '\n' ' ')")
```

# interactive script invoking editor and processing results
```bash
#!/bin/bash

DEBUG=0
EDITOR="vim -c 'set ft=diff'"

NORM="\033[00m"
BOLD="\033[01m"

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
VIOLET="\033[35m"
AZURE="\033[36m"

O="${NORM}[${BOLD}${GREEN}+${NORM}]"
E="${NORM}[${BOLD}${RED}-${NORM}]"
Q="${NORM}[${BOLD}${VIOLET}?${NORM}]"
I="${NORM}[${BOLD}${YELLOW}i${NORM}]"

directories=()
while IFS=  read -r -d $'\0'; do
  (( "${DEBUG}" )) && echo "${REPLY}"
  directories+=("${REPLY}")
done < <(find ./ -mindepth 1 -maxdepth 1 -type d -print0)
directoreis=($(echo "${directories[*]}" | tr ' ' '\n' | sort | tr '\n' ' '))
(( "${DEBUG}" )) &&  echo "${directories[@]}"

temp=$(mktemp)

echo "# in vim use :cq to abort!," >> "${temp}"
echo "# :q! will cancel all modifications and delete all files with \"-\" at begining of line" >> "${temp}"
echo "# :wq will save the modified state and delete all files with \"-\" at the begining of line" >> "${temp}"
echo "#" >> "${temp}"
echo "# in other editors either change all \"-\" to \"+\" or delete all lines if you wish to cancel." >> "${temp}"
echo "" >> "${temp}"

for d in "${directoreis[@]}"; do
  echo -e "${O} directory: ${a}"
  DELETE=()
  for f in $(find "${d}" -type f | sort); do
    ext="${f##*.}"
    (( "${DEBUG}" )) && echo "${ext}: ${f}"
    case ${f} in
      # backup files
      *.bak)
        echo "- ${f}" >> "${temp}"
        ;;
      # PERMAS Analysis
      *.uci)
        echo "+ ${f}" >> "${temp}"
        ;;
      # Model files
      *.bif|*.dat[0-9]*|*.pmat*)
        echo "+ ${f}" >> "${temp}"
        ;;
      # Analysis result logs
      *.pro|*.res)
        echo "+ ${f}" >> "${temp}"
        ;;
      # Text files, ACCE and mpffre results
      *.txt|*ACCE*.post|*mpffre*|*frcsst*.post)
        echo "+ ${f}" >> "${temp}"
        ;;
      # Other files
      *.png|*.xls|*.xlsx|*.xlsm)
        echo "+ ${f}" >> "${temp}"
        ;;
      # PERMAS results
      *.hdf|*.bof|*.bifo|*.dat|*.dato|*.dato.gz|*.post|*.post.gz|*.step|*.e[0-9]*|*.o[0-9]*|*.pe[0-9]*|*.po[0-9]*)
        echo "- ${f}" >> "${temp}"
        ;;
      *)
        echo "+ ${f}" >> "${temp}"
        ;;
    esac
  done
done

for f in ./*.{po,pe,o,e}[0-9]*; do
  echo "- ${f}" >> "${temp}"
done

eval "$EDITOR ${temp}"
[[ "$?" -eq 0 ]] || exit 1

sed -e '/^-/!d' "${temp}" | sed -e 's|^- ||' | xargs rm -f --

rm -f "${temp}"
```

# common prefix
```bash
#!/bin/bash
# script to find common prefix in all files with defined suffix

suffix='.png'

prefix=`printf "%s\n" $(find . -maxdepth 1 -mindepth 1 -type f -name "*${suffix}") | sed -e '$!{N;s/^\(.*\).*\n\1.*$/\1\n\1/;D;}'`
echo $prefix

if [ "${prefix: -1}" = "_" ]; then
    # echo last char is _
    prefix=${prefix%"_"}
fi

if [ "${prefix:0:2}" = "./" ]; then
    # echo name starts with ./
    prefix=${prefix#"./"}
fi

name=${prefix}${suffix}
echo $name
```
# parameter substitution
From: https://tldp.org/LDP/abs/html/parameter-substitution.html

## default value
__syntax__: `${parameter-default}` or `${parameter:-default}`

if `parameter` is not declared:
```bash
#!/bin/bash

echo "${username-`whoami`}"
```
returns the result of `whoami`if `$username` is not declared

if `parameter` is either not declared or set to __null__:
```bash
#!/bin/bash
username=""

echo "${username:-`whoami`}"
```
returns the result of `whoami`if `$username` is not declared or is null

__syntax__: `${parameter=default}` or `${parameter:=default}`

if `parameter` is not declared:
```bash
#!/bin/bash

echo "${var=abc}"
echo "${var}" # now $var = "abc"
echo "${var=xyz}" # already var = abc, therefore the value does not change
```

if `parameter` is either not declared or set to __null__:
```bash
#!/bin/bash
var=""
echo "${var:=abc}" # var = abc if var is null
echo "${var:=xyz}" # already var = abc, therefore the value does not change
```

__syntax__: `${parameter+alt_value}` or `${parameter:+alt_value}`
If parameter set, use alt_value, else use null string.
Both forms nearly equivalent. The : makes a difference only when parameter has been declared and is null, see below.
```bash
#!/bin/bash

echo "###### \${parameter+alt_value} ########"
echo

a=${param1+xyz}
echo "a = $a"      # a =

param2=
a=${param2+xyz}
echo "a = $a"      # a = xyz

param3=123
a=${param3+xyz}
echo "a = $a"      # a = xyz

echo
echo "###### \${parameter:+alt_value} ########"
echo

a=${param4:+xyz}
echo "a = $a"      # a =

param5=
a=${param5:+xyz}
echo "a = $a"      # a =
# Different result from   a=${param5+xyz}

param6=123
a=${param6:+xyz}
echo "a = $a"      # a = xyz
```

__syntax__: `${parameter?err_msg}` or `${parameter:?err_msg}`
If parameter set, use it, else print err_msg and abort the script with an exit status of 1.
Both forms nearly equivalent. The : makes a difference only when parameter has been declared and is null, as above.
```bash
#!/bin/bash

#  Check some of the system's environmental variables.
#  This is good preventative maintenance.
#  If, for example, $USER, the name of the person at the console, is not set,
#+ the machine will not recognize you.

: ${HOSTNAME?} ${USER?} ${HOME?} ${MAIL?}
  echo
  echo "Name of the machine is $HOSTNAME."
  echo "You are $USER."
  echo "Your home directory is $HOME."
  echo "Your mail INBOX is located in $MAIL."
  echo
  echo "If you are reading this message,"
  echo "critical environmental variables have been set."
  echo
  echo

# ------------------------------------------------------

#  The ${variablename?} construction can also check
#+ for variables set within the script.

ThisVariable=Value-of-ThisVariable
#  Note, by the way, that string variables may be set
#+ to characters disallowed in their names.
: ${ThisVariable?}
echo "Value of ThisVariable is $ThisVariable".

echo; echo


: ${ZZXy23AB?"ZZXy23AB has not been set."}
#  Since ZZXy23AB has not been set,
#+ then the script terminates with an error message.

# You can specify the error message.
# : ${variablename?"ERROR MESSAGE"}


# Same result with:   dummy_variable=${ZZXy23AB?}
#                     dummy_variable=${ZZXy23AB?"ZXy23AB has not been set."}
#
#                     echo ${ZZXy23AB?} >/dev/null

#  Compare these methods of checking whether a variable has been set
#+ with "set -u" . . .



echo "You will not see this message, because script already terminated."

HERE=0
exit $HERE   # Will NOT exit here.

# In fact, this script will return an exit status (echo $?) of 1.
```

```bash
#!/bin/bash
# usage-message.sh

: ${1?"Usage: $0 ARGUMENT"}
#  Script exits here if command-line parameter absent,
#+ with following error message.
#    usage-message.sh: 1: Usage: usage-message.sh ARGUMENT

echo "These two lines echo only if command-line parameter given."
echo "command-line parameter = \"$1\""

exit 0  # Will exit here only if command-line parameter present.

# Check the exit status, both with and without command-line parameter.
# If command-line parameter present, then "$?" is 0.
# If not, then "$?" is 1.
```

## replace in string
__syntax__: `${var#Pattern}`, `${var##Pattern}`
`${var#Pattern}`: Remove from $var the shortest part of $Pattern that matches the front end of $var.
`${var##Pattern}`: Remove from $var the longest part of $Pattern that matches the front end of $var.
```bash
# Function from "days-between.sh" example.
# Strips leading zero(s) from argument passed.

strip_leading_zero () #  Strip possible leading zero(s)
{                     #+ from argument passed.
  return=${1#0}       #  The "1" refers to "$1" -- passed arg.
}                     #  The "0" is what to remove from "$1" -- strips zeros.
```

```bash
strip_leading_zero2 () # Strip possible leading zero(s), since otherwise
{                      # Bash will interpret such numbers as octal values.
  shopt -s extglob     # Turn on extended globbing.
  local val=${1##+(0)} # Use local variable, longest matching series of 0's.
  shopt -u extglob     # Turn off extended globbing.
  _strip_leading_zero2=${val:-0}
                       # If input was 0, return 0 instead of "".
}
```

```bash
echo `basename $PWD`        # Basename of current working directory.
echo "${PWD##*/}"           # Basename of current working directory.
echo
echo `basename $0`          # Name of script.
echo $0                     # Name of script.
echo "${0##*/}"             # Name of script.
echo
filename=test.data
echo "${filename##*.}"      # data
                            # Extension of filename.
```

__syntax__: `${var%Pattern}`, `${var%%Pattern}`
`${var%Pattern}`: Remove from $var the shortest part of $Pattern that matches the back end of $var.
`${var%%Pattern}`: Remove from $var the longest part of $Pattern that matches the back end of $var.

```bash

#!/bin/bash
# patt-matching.sh

# Pattern matching  using the # ## % %% parameter substitution operators.

var1=abcd12345abc6789
pattern1=a*c  # * (wild card) matches everything between a - c.

echo
echo "var1 = $var1"           # abcd12345abc6789
echo "var1 = ${var1}"         # abcd12345abc6789
                              # (alternate form)
echo "Number of characters in ${var1} = ${#var1}"
echo

echo "pattern1 = $pattern1"   # a*c  (everything between 'a' and 'c')
echo "--------------"
echo '${var1#$pattern1}  =' "${var1#$pattern1}"    #         d12345abc6789
# Shortest possible match, strips out first 3 characters  abcd12345abc6789
#                                     ^^^^^               |-|
echo '${var1##$pattern1} =' "${var1##$pattern1}"   #                  6789      
# Longest possible match, strips out first 12 characters  abcd12345abc6789
#                                    ^^^^^                |----------|

echo; echo; echo

pattern2=b*9            # everything between 'b' and '9'
echo "var1 = $var1"     # Still  abcd12345abc6789
echo
echo "pattern2 = $pattern2"
echo "--------------"
echo '${var1%pattern2}  =' "${var1%$pattern2}"     #     abcd12345a
# Shortest possible match, strips out last 6 characters  abcd12345abc6789
#                                     ^^^^                         |----|
echo '${var1%%pattern2} =' "${var1%%$pattern2}"    #     a
# Longest possible match, strips out last 12 characters  abcd12345abc6789
#                                    ^^^^                 |-------------|

# Remember, # and ## work from the left end (beginning) of string,
#           % and %% work from the right end.

echo

exit 0
```

```bash
#!/bin/bash
# rfe.sh: Renaming file extensions.
#
#         rfe old_extension new_extension
#
# Example:
# To rename all *.gif files in working directory to *.jpg,
#          rfe gif jpg


E_BADARGS=65

case $# in
  0|1)             # The vertical bar means "or" in this context.
  echo "Usage: `basename $0` old_file_suffix new_file_suffix"
  exit $E_BADARGS  # If 0 or 1 arg, then bail out.
  ;;
esac


for filename in *.$1
# Traverse list of files ending with 1st argument.
do
  mv $filename ${filename%$1}$2
  #  Strip off part of filename matching 1st argument,
  #+ then append 2nd argument.
done

exit 0
```

## substring replacement
__syntax__: `${var:pos}`
Variable var expanded, starting from offset pos.

__syntax__: `${var:pos:len}`
Expansion to a max of len characters of variable var, from offset pos.

__syntax__: `${var/Pattern/Replacement}`
First match of Pattern, within var replaced with Replacement.
If Replacement is omitted, then the first match of Pattern is replaced by nothing, that is, deleted.

__syntax__: `${var//Pattern/Replacement}`
Global replacement. All matches of Pattern, within var replaced with Replacement.
As above, if Replacement is omitted, then all occurrences of Pattern are replaced by nothing, that is, deleted.

Using pattern matching to parse arbitrary strings:
```bash

#!/bin/bash

var1=abcd-1234-defg
echo "var1 = $var1"

t=${var1#*-*}
echo "var1 (with everything, up to and including first - stripped out) = $t"
#  t=${var1#*-}  works just the same,
#+ since # matches the shortest string,
#+ and * matches everything preceding, including an empty string.
# (Thanks, Stephane Chazelas, for pointing this out.)

t=${var1##*-*}
echo "If var1 contains a \"-\", returns empty string...   var1 = $t"


t=${var1%*-*}
echo "var1 (with everything from the last - on stripped out) = $t"

echo

# -------------------------------------------
path_name=/home/bozo/ideas/thoughts.for.today
# -------------------------------------------
echo "path_name = $path_name"
t=${path_name##/*/}
echo "path_name, stripped of prefixes = $t"
# Same effect as   t=`basename $path_name` in this particular case.
#  t=${path_name%/}; t=${t##*/}   is a more general solution,
#+ but still fails sometimes.
#  If $path_name ends with a newline, then `basename $path_name` will not work,
#+ but the above expression will.
# (Thanks, S.C.)

t=${path_name%/*.*}
# Same effect as   t=`dirname $path_name`
echo "path_name, stripped of suffixes = $t"
# These will fail in some cases, such as "../", "/foo////", # "foo/", "/".
#  Removing suffixes, especially when the basename has no suffix,
#+ but the dirname does, also complicates matters.
# (Thanks, S.C.)

echo

t=${path_name:11}
echo "$path_name, with first 11 chars stripped off = $t"
t=${path_name:11:5}
echo "$path_name, with first 11 chars stripped off, length 5 = $t"

echo

t=${path_name/bozo/clown}
echo "$path_name with \"bozo\" replaced  by \"clown\" = $t"
t=${path_name/today/}
echo "$path_name with \"today\" deleted = $t"
t=${path_name//o/O}
echo "$path_name with all o's capitalized = $t"
t=${path_name//o/}
echo "$path_name with all o's deleted = $t"

exit 0
```

__syntax__: `${var/#Pattern/Replacement}`
If prefix of var matches Pattern, then substitute Replacement for Pattern.

__syntax__: `${var/%Pattern/Replacement}`
If suffix of var matches Pattern, then substitute Replacement for Pattern.

Matching patterns at prefix or suffix of string:
```bash

#!/bin/bash
# var-match.sh:
# Demo of pattern replacement at prefix / suffix of string.

v0=abc1234zip1234abc    # Original variable.
echo "v0 = $v0"         # abc1234zip1234abc
echo

# Match at prefix (beginning) of string.
v1=${v0/#abc/ABCDEF}    # abc1234zip1234abc
                        # |-|
echo "v1 = $v1"         # ABCDEF1234zip1234abc
                        # |----|

# Match at suffix (end) of string.
v2=${v0/%abc/ABCDEF}    # abc1234zip123abc
                        #              |-|
echo "v2 = $v2"         # abc1234zip1234ABCDEF
                        #               |----|

echo

#  ----------------------------------------------------
#  Must match at beginning / end of string,
#+ otherwise no replacement results.
#  ----------------------------------------------------
v3=${v0/#123/000}       # Matches, but not at beginning.
echo "v3 = $v3"         # abc1234zip1234abc
                        # NO REPLACEMENT.
v4=${v0/%123/000}       # Matches, but not at end.
echo "v4 = $v4"         # abc1234zip1234abc
                        # NO REPLACEMENT.

exit 0	
```

__syntax__: `${!varprefix*}, ${!varprefix@}`
Matches names of all previously declared variables beginning with varprefix.
```bash
# This is a variation on indirect reference, but with a * or @.
# Bash, version 2.04, adds this feature.

xyz23=whatever
xyz24=

a=${!xyz*}         #  Expands to *names* of declared variables
# ^ ^   ^           + beginning with "xyz".
echo "a = $a"      #  a = xyz23 xyz24
a=${!xyz@}         #  Same as above.
echo "a = $a"      #  a = xyz23 xyz24

echo "---"

abc23=something_else
b=${!abc*}
echo "b = $b"      #  b = abc23
c=${!b}            #  Now, the more familiar type of indirect reference.
echo $c            #  something_else
```

# regex
```bash
#!/bin/bash

cwd="$(pwd)"

#      (       1      )(     2     )_(      3       )_(       4      )_(       5      )
regex='([[:alnum:]]{4})([[:alpha:]])_([[:alnum:]]{3})_([[:alnum:]]{4})_([[:digit:]]{4})'

[[ $cwd =~ $regex ]]
if [[ ${#BASH_REMATCH[@]} == 6 ]]; then
    for (( i=0; i<6; i++ )); do
        echo "${BASH_REMATCH[$i]}"
    done
fi
```

[back to index](index.md)
