# Contents

- [install](#install)
    - [install static builds](#install#install static builds)

# install
## install static builds
on example of `ffmpeg`:
From: https://www.vultr.com/docs/how-to-install-the-latest-static-build-of-ffmpeg
1. create directory in `/opt`
```bash
sudo mkdir /opt/ffmpeg
cd /opt/ffmpeg
```

1. download the archive:
if using the master build
```bash
sudo wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
sudo wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz.md5
md5sum -c ffmpeg-git-amd64-static.tar.xz.md5
```

if using the latest release build:
```bash
sudo wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
sudo wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz.md5
md5sum -c ffmpeg-release-amd64-static.tar.xz.md5
```

__Verify__ that `md5sum` returns an __OK__ message before proceeding.

3. extract the static build from the archive:
```bash
sudo tar xvf ffmpeg*.xz
cd ffmpeg-*-static
ls
```

you should see something like this:
```bash
ffmpeg  ffprobe  GPLv3.txt  manpages  model  qt-faststart  readme.txt
```

4. install the binaries globally:
```bash
sudo ln -s "${PWD}/ffmpeg" /usr/local/bin/
sudo ln -s "${PWD}/ffprobe" /usr/local/bin/
```


[back to index](index.md)
