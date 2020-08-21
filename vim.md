# Contents

- [debug](#debug)
    - [start logfile](#debug#start logfile)
    - [measure startup time](#debug#measure startup time)
    - [vim without .vimrc and plugins](#debug#vim without .vimrc and plugins)
    - [vimdiff](#debug#vimdiff)
        - [ignore all whitespaces](#debug#vimdiff#ignore all whitespaces)
- [vimwiki](#vimwiki)
    - [fix links](#vimwiki#fix links)
- [highlight whole lines](#highlight whole lines)
- [batch file processing](#batch file processing)
- [floating point operations using awk](#floating point operations using awk)
- [generate tags for python](#generate tags for python)

# debug
## start logfile
```bash
vim -V20 README.md  2>&1 | tee logfile
```

## measure startup time
current configuration including plugins and .vimrc
```bash
vim --startuptime vim.log
```

vim without .vimrc and plugins
```bash
vim -u NONE --startuptime vim.log
```

possible options (see `:h --noplugin`):
| argument\load: | vimrc files | plugins | defaults.vim |
|----------------|:-----------:|:-------:|:------------:|
| (nothing)      |   **yes**   | **yes** |   **yes**    |
| -u NONE        |     no      |   no    |      no      |
| -u DEFAULTS    |     no      |   no    |   **yes**    |
| -u NORC        |     no      | **yes** |      no      |
| --noplugin     |   **yes**   |   no    |   **yes**    |

## vim without .vimrc and plugins
```bash
vim -u NONE -N
```
> -u NONE   no .vimrc, plugins or defaults
> -N	    start with `:set nocompatible`

same can be achieved with
```bash
vim -u DEFAULTS
```

## vimdiff
### ignore all whitespaces

```vim
" ignore case
set diffopt+=icase
" ignore whitespace
set diffopt+=iwhite

" custom diff expression
set diffexpr=DiffIgnoreWhite()

" custom diff function
" ignore leading and trailing whitespaces (the -w option)
function DiffIgnoreWhite()
  let opt = ""
  if &diffopt =~ "icase"
    let opt = opt . "-i "
  endif
  if &diffopt =~ "iwhite"
    let opt = opt . "-w "  " -w instead of -b to ignore all white spaces
  endif
  silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
endfunction
```

`:h diff-diffexpr`

```vim
function! PermasDiff()
    let opt = ""
    if &diffopt =~ "icase"
      let opt = opt . "-i "
    endif
    if &diffopt =~ "iwhite"
      let opt = opt . "-w "  " -w instead of -b to ignore all white spaces
    endif
    if join(g:permas_diffopt, ";") =~ "icomment"
      let l:file_in = StripComments(v:fname_in)
      let l:file_new = StripComments(v:fname_new)
      silent execute "!diff -a --binary " . opt . " " . l:file_in . " " .l:file_new . " > " . v:fname_out
    else
      silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
    endif
  endfunction
 
  function! StripComments(fname)
    let l:fname = "<(sed -E 's/\\!\.*\$//' " . a:fname . ")"
    echom l:fname
    return l:fname
  endfunction
```

# vimwiki
## fix links
replace spaces in url
```vim
:%s/\v(\<a href\="#)(.*)(\.md)=(\.html)("\>)/\=submatch(1).substitute(submatch(2),' ','%20','g').submatch(5)/g
```

delete .md from url
```vim
:%s/\v(\<a href\=".*)(\.md)(\.html"\>)/\1\3/g
```

the same thing using **bash** and **sed**
```bash
#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
  echo "${f}"
  # replace .md.html in links with .html
  sed -i -E 's/\.md\.html/.html/g' "$f"
  # for each line in grep output, grep is for relative links
  # they are unfortunately ending with .html and contain spaces
  # grep returns only matched string
  grep -Eo 'href="#\S.*\.html"' "${f}" | while read -r url ; do
#     echo "${url}"
    # replace .md with nothing, spaces with %20 and .html at the end with nothing
    urln=$(echo "${url}" | sed -E 's/\.md//' | sed -E 's/ /%20/g' | sed -E 's/\.html"/"/')
#     echo "${url}" '-->' "${urln}"
    # replace in file (gnu sed => -i possible, without temp file)
    sed -i -E 's/'"${url}"'/'"${urln}"'/' "${f}"
    # invoked without extended regex to capture characters to be escaped
    sed -i 's/'"${url}"'/'"${urln}"'/' "${f}"
  done
done
```

another possibility using **awk**:
```bash
#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
#   cat "${f}" | awk 'match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr) { gsub(/ /, "%20", arr[2]); gsub(/\.html$/, "", arr[2]); gsub(/\.md/, "", arr[2]); print arr[1] arr[2] arr[3] }'
  cat "${f}" | awk '{ match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr); if (arr[2] == "") print $0; else { gsub(/ /, "%20", arr[2]); gsub(/\.html$/, "", arr[2]); gsub(/\.md/, "", arr[2]); print arr[1] arr[2] arr[3] }; }' > "${f}"
done
```

# highlight whole lines
syntax highlighting does not support this feature but it can be done via `:sign` command
see `:h sign-commands`

plugin function:
```vim
if exists("b:permas_uci_sign")                                                 
  finish                                                                       
endif                                                                          
                                                                               
silent sign define stopline linehl=ErrorMsg                                    
                                                                               
function! PermasUCIPlaceSigns()                                                
  let l:line = 1                                                               
  silent execute 'sign unplace *'                                              
  while l:line <= line('$')                                                    
    if getline(l:line) =~# '\v\c^\s*stop(\s*|\s+!.*)$'                         
      silent execute 'sign place 1 name=stopline line=' . l:line . ' file=' . expand('%')
    endif                                                                      
    let l:line += 1                                                            
  endwhile                                                                     
endfunction                                                                    
                                                                               
let b:permas_uci_sign = 1 
```

ftdetect:
```vim
au BufRead,BufEnter,BufLeave,InsertLeave,CursorMoved *.uci call PermasUCIPlaceSigns()
```

# batch file processing

1. first read all corresponding files into args list
```vim
:args ./**/*unique_filename_part*.txt
```
this will populate the `:args` list and open the first file for editing

useful commands:
`:args` displays the files in `args` list
`:set hidden` allows for switching between unsaved buffers
`:first` go to the first buffer in args list
`:last` go to the last buffer in args list
`:next` go to the next buffer in args list
`:previous` go to the previous buffer in args list
`:argdo command` execute command for each file in `args` list

2. run command using `:argdo`
substitute:
```vim
:argdo %s/pattern/replace/g
```

delete using range:
```vim
:argdo 8,40d
```
some range specifiers:
    .   current line
    0   first line of file
    $   last line of file
    %   the entire file

delete using pattern:
```vim
:argdo g/pattern/d
```

delete using two patterns:
```vim
:argdo g/pattern1/.,./pattern2/d
```

this is using the `:global` command:
```vim
:g[lobal]/pattern/[range]command
```
`:global` runs command on each line containing pattern, `.` specifies the line returned from `global` command
=> `.,./pattern2/d` means execute `delete` on range from matched line to line containing `pattern2`
the range can also look like (delete between patterns):
```vim
:g/pattern1/.+1,./pattern2/-1d
```

to delete lines not containing pattern:
```vim
:argdo v/pattern1/d
```

3. save files using `:argdo`
```vim
:argdo exec 'w '.substitute(expand('%:p'),"\.txt$",'_new.txt','')
```
or to just save all
```vim
:wall!
```

4. quit loaded files without saving
```vim
:argdo quit!
```
or
```vim
:qall!
```

# floating point operations using awk
autoformat:
```vim
:.r !awk 'BEGIN { print 3.12E-01 * 2.1E+05 }'
```

custom formating (`%` must be escaped as otherwise it will be expanded to filename by vim):
```vim
:.r !awk 'BEGIN { printf "\%16.2e", 3.12E-01 * 2.1E+05 }'
```

store result into register (or variable):
```vim
:let @c=system('awk "BEGIN { printf \"%16.2e\", 3.12E-01 * 2.1E+05 }"')
```

and use registers for input:
```vim
:let @c=system('awk "BEGIN { printf \"%16.2e\", '.@a.' * '.@b.' }"')
```

# generate tags for python
From: https://stackoverflow.com/questions/47948545/ctags-vim-and-python-code
```vim
cd %:p:h
!ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags %:p
```

this will create directory `tags` in CWD

to see Tag List use:
```vim
Tlist
```

to set Tag List width use (in `.vimrc`):
```vim
" tag list window width, default is 30
let Tlist_WinWidth = 50
```

[back to index](index.md)
