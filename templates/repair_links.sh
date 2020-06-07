#!/bin/bash

for f in ~/vimwiki/vimwiki_html/*.html; do
  echo "${f}"
  sed -i -E 's/\.md\.html/.html/g' "$f"
  fl=$(cat "${f}")
  grep -Eo 'href="#\S.*\.html"' "${f}" | while read -r url ; do
#     echo "${url}"
    urln=$(echo "${url}" | sed -E 's/\.md//' | sed -E 's/ /%20/g' | sed -E 's/\.html"/"/')
    echo "${url}" '-->' "${urln}"
#     fl="${fl//${url}/${urln}}"
    sed -i -E "s/${url}/${urln}/g" "${f}"
    sed -i "s/${url}/${urln}/g" "${f}"
  done
#   echo "${fl}" > "${f}"
done
