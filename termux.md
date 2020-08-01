# Contents

- [backup and restore](#backup and restore)

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
