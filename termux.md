# Contents

- [access android filesystem](#access android filesystem)
- [backup and restore](#backup and restore)
- [do not show login message](#do not show login message)

# access android filesystem
for `termux` to access android filesystem it is needed to allow __access to storage__:
settings -> Apps -> Termux -> Permissions

# backup and restore
from: https://jnet.forumotion.com/t1569-how-to-backup-and-restore-android-app-like-termux

backup:
```bash
cd /data/data/com.termux/files
tar -cvzf /sdcard/Download/termux.tgz home usr
 ```
 
 restore:
```bash
cd /data/data/com.termux/files
tar -xvzf /sdcard/Download/termux.tgz
```

# do not show login message
to disable showing the login message create file `.hushlogin` in `${HOME}`
```bash
touch ~/.hushlogin
```

[back to index](index.md)
