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
  exit 1
fi

VER="$1" # fmt release version (tag) to download, e.g. "7.1.3"
DIR="fmt-${VER}"
ZIP="${DIR}.zip"
MANIFEST_TEMPLATE="library.jsonc"
MANIFEST="library.json"

set -x

wget "https://github.com/fmtlib/fmt/releases/download/${VER}/${ZIP}"
unzip "${ZIP}"
rm "${ZIP}"

cp "${MANIFEST_TEMPLATE}" "${DIR}/${MANIFEST}"
sed -i '' -e "/^[[:space:]]*\/\//d;s/\${VER}/${VER}/" "${DIR}/${MANIFEST}"

pio package pack "${DIR}"

set +x

echo ""
echo "Test the archived library locally and publish it by running"
echo ""
echo "  pio package publish ${DIR}.tar.gz"
echo ""
