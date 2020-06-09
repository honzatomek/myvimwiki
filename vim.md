# Contents

- [debug](#debug)
    - [start logfile](#debug#start logfile)
    - [measure startup time](#debug#measure startup time)
    - [vim without .vimrc and plugins](#debug#vim without .vimrc and plugins)
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

[back to index](index.md)
