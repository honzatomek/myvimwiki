# Contents

- [debug](#debug)
    - [start logfile](#debug#start logfile)

# debug
## start logfile
```brush: bash
vim -V20 README.md  2>&1 | tee logfile
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

[back to index](index.md)
