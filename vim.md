# Contents

- [debug](#debug)
    - [start logfile](#debug#start logfile)
    - [measure startup time](#debug#measure startup time)
    - [vim without .vimrc and plugins](#debug#vim without .vimrc and plugins)
    - [vimdiff](#debug#vimdiff)
        - [ignore all whitespaces](#debug#vimdiff#ignore all whitespaces)
- [vimwiki](#vimwiki)
    - [fix links](#vimwiki#fix links)

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
~   if join(g:permas_diffopt, ";") =~ "icomment"                                 
+     let l:file_in = StripComments(v:fname_in)                                  
+     let l:file_new = StripComments(v:fname_new)                                
+     silent execute "!diff -a --binary " . opt . " " . l:file_in . " " .l:file_new . " > " . v:fname_out
+   else                                                                         
+     silent execute "!diff -a --binary " . opt . v:fname_in . " " . v:fname_new . " > " . v:fname_out
+   endif                                                                        
+ endfunction                                                                    
+                                                                                
+ function! StripComments(fname)                                                 
+   let l:fname = "<(sed -E 's/\\!\.*\$//' " . a:fname . ")"                     
+   echom l:fname                                                                
+   return l:fname                                                               
  endfunction
```

# vimwiki
## fix links
replace spaces in url
```vim
%s/\v(\<a href\="#)(.*)(\.md)=(\.html)("\>)/\=submatch(1).substitute(submatch(2),' ','%20','g').submatch(5)/g
```

delete .md from url
```vim
%s/\v(\<a href\=".*)(\.md)(\.html"\>)/\1\3/g
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


[back to index](index.md)
