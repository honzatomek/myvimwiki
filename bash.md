# Contents

- [SED](#SED)
    - [replace file](#SED#replace file)
    - [replace all occurences](#SED#replace all occurences)
    - [extended regexp](#SED#extended regexp)
    - [prefilter lines for regexp](#SED#prefilter lines for regexp)
    - [REGEXP](#SED#REGEXP)
    - [Examples](#SED#Examples)
- [GREP](#GREP)
    - [print only matched string](#GREP#print only matched string)

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


# GREP
## print only matched string
`grep -Eo 'pattern' file`

> `-E` means extended regexp
> `-o` means only matching string


# useful commands
## cat                                                                           
concatenate all files matching to a single file:                                 
`cat *.pro >> profiles.txt`                                                      
                                                                                 
## cut                                                                           
cut delimited string (`-d`) and select 4th field (`-f`):                         
`xrandr | grep -v 'DVI\|DP\|Screen' | cut -d ' ' -f 4`                           
                                                                                 
## find                                                                          
finds all files that satisfy `-name` expression in all subfolder levels limited by `-maxdepth` and `-mindepth` (`-type = file`):
`find . -maxdepth 1 -mindepth 1 -type f -name "*.png"`                           
                                                                                 
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


[back to index](index.md)
