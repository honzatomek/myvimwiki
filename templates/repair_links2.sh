#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
#   cat "${f}" | awk 'match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr) { gsub(/ /, "%20", arr[2]); gsub(/\.html$/, "", arr[2]); gsub(/\.md/, "", arr[2]); print arr[1] arr[2] arr[3] }'
  awk '
  {
    match($0, /(^.*<a href=\")(#.*)(\">.*$)/, arr);
    if (arr[2] == "")
      print $0;
    else
      {
        gsub(/ /, "%20", arr[2]);
        gsub(/\.html$/, "", arr[2]);
        gsub(/\.md/, "", arr[2]);
        print arr[1] arr[2] arr[3] };
      }' "${f}" # > "${f}"
done

