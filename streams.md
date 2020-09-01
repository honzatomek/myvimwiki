# Contents

- [ffmpeg](#ffmpeg)
    - [cut video](#ffmpeg#cut video)
- [streamlink](#streamlink)
    - [custom streamlink function](#streamlink#custom streamlink function)
    - [chaturbate plugin](#streamlink#chaturbate plugin)

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

## make gif
```bash
# create duplicate image frames for gif generation
a=0
for i in *.png; do
  new=$(printf "sequence%04d.png" "$a") #04 pad to length of 4
  cp -- "$i" "$new"
  let a=a+1
done

# create gif file
palette="palette.png"
filters="fps=10,scale=1200:-1:flags=lanczos"
ffmpeg -thread_queue_size 1024 -framerate $framerate -i sequence%04d.png -vf "$filters,palettegen" -y $palette
ffmpeg -thread_queue_size 1024 -framerate $framerate -i sequence%04d.png -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "${prefix}.gif"

# remove help files
rm -f sequence*.png
rm -f ${palette}
```

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
    url="${1}"
  else
    url="${1}/"
  fi
  name="$(echo $url | rev | cut -d/ -f2 | rev)"
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
## chaturbate plugin
chaturbate plugin no longer supported (NSFW), it is therefore needed to add the following file to
~/.config/streamlink/plugins/chaturbate.py (if path does not exist, create it).
```python
import re
import uuid

from streamlink.plugin import Plugin
from streamlink.plugin.api import validate
from streamlink.stream import HLSStream

API_HLS = "https://chaturbate.com/get_edge_hls_url_ajax/"

_url_re = re.compile(r"https?://(\w+\.)?chaturbate\.com/(?P<username>\w+)")

_post_schema = validate.Schema(
    {
        "url": validate.text,
        "room_status": validate.text,
        "success": int
    }
)


class Chaturbate(Plugin):
    @classmethod
    def can_handle_url(cls, url):
        return _url_re.match(url)

    def _get_streams(self):
        match = _url_re.match(self.url)
        username = match.group("username")

        CSRFToken = str(uuid.uuid4().hex.upper()[0:32])

        headers = {
            "Content-Type": "application/x-www-form-urlencoded",
            "X-CSRFToken": CSRFToken,
            "X-Requested-With": "XMLHttpRequest",
            "Referer": self.url,
        }

        cookies = {
            "csrftoken": CSRFToken,
        }

        post_data = "room_slug={0}&bandwidth=high".format(username)

        res = self.session.http.post(API_HLS, headers=headers, cookies=cookies, data=post_data)
        data = self.session.http.json(res, schema=_post_schema)

        self.logger.info("Stream status: {0}".format(data["room_status"]))
        if (data["success"] is True and data["room_status"] == "public" and data["url"]):
            for s in HLSStream.parse_variant_playlist(self.session, data["url"]).items():
                yield s


__plugin__ = Chaturbate
```

[back to index](index.md)
