#!/bin/sh
set -eu

if [ "$#" -lt 1 ]; then
  echo "Usage:"
  echo ""
  echo "  $0 <fmt_release_version>"
  echo ""
  echo "Check fmt releases at"
  echo ""
  echo "  https://github.com/fmtlib/fmt/releases"
  echo ""
  exit
fi

VER="$1" # fmt release version (tag) to download, e.g. "7.1.3"
DIR="fmt-${VER}"
ZIP="${DIR}.zip"
MANIFEST="library.json"

set -x

wget https://github.com/fmtlib/fmt/releases/download/${VER}/${ZIP}
unzip ${ZIP}
rm ${ZIP}

cp ${MANIFEST} ${DIR}

sed -i '' -e "/^[[:space:]]*\/\//d;s/\${VER}/${VER}/" ${DIR}/library.json

set +x

echo ""
echo "Archive the package for local testing by running"
echo ""
echo "  pio package pack ${DIR}"
echo ""
echo "Publish the library by running"
echo ""
echo "  pio package publish ${DIR}"
echo ""
