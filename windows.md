# Contents

- [disk](#disk)
    - [repair](#disk#repair)
        - [chkdsk](#disk#repair#chkdsk)

# disk
## repair
__NEVER__ run `defragment disk` before `chkdsk` if there are performance issues.

### chkdsk
serves to check and repair wrong sectors on a disk formatted as __FAT32__ or __NTFS__
ran from `cmd.exe`

to run `chkdsk` on other disk than `c:`:
```bat
chkdsk f: /f /r /x
```

command: chkdsk [volume - c:] flags
for help use `chkdsk /?`

some flags:
`/?` - shows help
`/f` - fix errors on disk
`/r` - find and repair bad sectors, restore readable data, implies `/f`
`/x` - unmount the disk if necesarry, chkdsk then runs on the disk without anything locking or accessing its data, implies `/f`
