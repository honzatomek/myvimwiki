# Contents

- [ffmpeg](#ffmpeg)
    - [cut video](#ffmpeg#cut video)
- [streamlink](#streamlink)
    - [custom streamlink function](#streamlink#custom streamlink function)

# ffmpeg
## cut video
the following command cuts __10 minutes__ from video_in.mp4 starting at __minute 5__ (therefore 00:05:00 - 00:15:00):
```bash
ffmpeg -ss 00:05:00 -i video_in.mp4 -c copy -t 00:10:00 video_out.mp4
```
`-ss` start time
`-i` input file
`-c` action
`-t` duration

the same using absolute time:
```bash
ffmpeg -i video_in.mp4 -c copy -ss 00:05:00 -to 00:15:00 video_out.mp4
```
`-i` input file
`-c` action
`-ss` start time
`-to` end time

# streamlink
## custom streamlink function
```bash
#!/bin/bash -
#===============================================================================
#
#          FILE: sl.sh
#
#         USAGE: ./sl.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 08/03/2020 00:14
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

stream=""
[ "$#" == 2 ] && stream="$2"

if [[ $1 =~ https://www.chaturbate.com/* ]] || [[ $1 =~ https://chaturbate.com/* ]] || [[ $1 =~ www.chaturbate.com/* ]] || [[ $1 =~ chaturbate.com/* ]]; then
  if [[ "${1: -1}" == '/' ]]; then
    url="$1"
    name="$(echo $url | rev | cut -d/ -f2 | rev)"
  else
    url="${1}/"
    name="$(echo $url | rev | cut -d/ -f2 | rev)"
  fi
else
  name="$1"
  url="https://www.chaturbate.com/${name}/"
fi
now="$(date +%y%m%d-%H%M%S)"
if [[ -z "$stream" ]]; then
  streamlink "$url" -o "${HOME}/Downloads/custom/chaturbate/${name}_${now}.mp4"
else
  streamlink "$url" "$stream" -o "${HOME}/Downloads/custom/chaturbate/${name}_${now}.mp4"
fi
```

[back to index](index.md)
