#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
  echo "${f}"
  sed -i -E 's/\.md\.html/.html/g' "$f"
  grep -Eo 'href="#\S.*\.html"' "${f}" | while read -r url ; do
#     echo "${url}"
    urln=$(echo "${url}" | sed -E 's/\.md//' | sed -E 's/ /%20/g' | sed -E 's/\.html"/"/')
#     echo "${url}" '-->' "${urln}"
    sed -i -E 's/'"${url}"'/'"${urln}"'/' "${f}"
  done
done
